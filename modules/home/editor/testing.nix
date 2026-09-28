_:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        action.__raw = "function() require('neotest').run.run() end";
        options.desc = "Run nearest test";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action.__raw = "function() require('neotest').run.run(vim.fn.expand('%')) end";
        options.desc = "Run test file";
      }
      {
        mode = "n";
        key = "<leader>tl";
        action.__raw = "function() require('neotest').run.run_last() end";
        options.desc = "Run last test";
      }
      {
        mode = "n";
        key = "<leader>ts";
        action.__raw = "function() require('neotest').summary.toggle() end";
        options.desc = "Toggle test summary";
      }
      {
        mode = "n";
        key = "<leader>to";
        action.__raw = "function() require('neotest').output_panel.toggle() end";
        options.desc = "Toggle test output";
      }
      {
        mode = "n";
        key = "<leader>tS";
        action.__raw = "function() require('neotest').run.stop() end";
        options.desc = "Stop nearest test";
      }
    ];

    plugins.neotest = {
      enable = true;
      adapters = {
        golang.enable = true;
        jest.enable = true;
        playwright.enable = true;
        python.enable = true;
        vitest.enable = true;
      };
    };
  };
}
