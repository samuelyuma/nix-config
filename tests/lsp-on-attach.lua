local body_path = assert(arg[1], "pass the Nix-evaluated onAttach body")
local file = assert(io.open(body_path, "r"))
local body = file:read("*a")
file:close()

local autocmds = {}
local clients_by_buffer = {}
local cleared_references = 0

local function remove_autocmds(predicate)
  for index = #autocmds, 1, -1 do
    if predicate(autocmds[index]) then
      table.remove(autocmds, index)
    end
  end
end

vim = {
  keymap = { set = function() end },
  api = {
    nvim_create_augroup = function(name, options)
      if options.clear then
        remove_autocmds(function(autocmd)
          return autocmd.group == name
        end)
      end
      return name
    end,
    nvim_create_autocmd = function(events, options)
      if type(events) == "string" then
        events = { events }
      end
      for _, event in ipairs(events) do
        table.insert(autocmds, {
          event = event,
          group = options.group,
          buffer = options.buffer,
          callback = options.callback,
        })
      end
    end,
    nvim_clear_autocmds = function(options)
      remove_autocmds(function(autocmd)
        return autocmd.group == options.group and autocmd.buffer == options.buffer
      end)
    end,
  },
  lsp = {
    buf = {
      rename = function() end,
      code_action = function() end,
      declaration = function() end,
      document_highlight = function() end,
      clear_references = function()
        cleared_references = cleared_references + 1
      end,
    },
    inlay_hint = {
      enable = function() end,
      is_enabled = function()
        return false
      end,
    },
    get_clients = function(options)
      return clients_by_buffer[options.bufnr] or {}
    end,
  },
}

package.preload["telescope.builtin"] = function()
  return setmetatable({}, {
    __index = function()
      return function() end
    end,
  })
end

local on_attach = assert(load("return function(client, bufnr)\n" .. body .. "\nend"))()

local function client(id)
  return {
    id = id,
    name = "test-lsp-" .. id,
    server_capabilities = {},
    supports_method = function(_, method)
      return method == "textDocument/documentHighlight"
    end,
  }
end

local first = client(1)
local second = client(2)
local other_buffer = client(3)
clients_by_buffer[10] = { first, second }
clients_by_buffer[11] = { other_buffer }

on_attach(first, 10)
on_attach(second, 10)
on_attach(other_buffer, 11)

local function autocmd_count(event, buffer)
  local count = 0
  for _, autocmd in ipairs(autocmds) do
    if autocmd.event == event and autocmd.buffer == buffer then
      count = count + 1
    end
  end
  return count
end

assert(autocmd_count("CursorHold", 10) == 1, "duplicate document-highlight handler")
assert(autocmd_count("CursorMoved", 10) == 1, "duplicate clear-reference handler")
assert(autocmd_count("LspDetach", 10) == 1, "missing buffer-local detach handler")
assert(autocmd_count("LspDetach", 11) == 1, "detach handler was cleared for another buffer")

local function detach(buffer, id)
  for _, autocmd in ipairs(autocmds) do
    if autocmd.event == "LspDetach" and autocmd.buffer == buffer then
      autocmd.callback({ buf = buffer, data = { client_id = id } })
      return
    end
  end
  error("no detach callback for buffer " .. buffer)
end

detach(10, first.id)
assert(autocmd_count("CursorHold", 10) == 1, "detaching one client removed another client's highlights")
assert(cleared_references == 0, "references cleared while another highlighting client remains")

clients_by_buffer[10] = { second }
detach(10, second.id)
assert(autocmd_count("CursorHold", 10) == 0, "highlight handlers remained after the final client detached")
assert(autocmd_count("CursorHold", 11) == 1, "detaching a client cleared another buffer's highlights")

print("LSP onAttach lifecycle checks passed")
