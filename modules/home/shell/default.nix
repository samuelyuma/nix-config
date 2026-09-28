{
  config,
  host,
  pkgs,
  ...
}:

{
  home.sessionPath = [
    "/etc/profiles/per-user/${host.username}/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "bun"
          "docker"
          "git"
          "uv"
        ];
      };

      plugins = [
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
          file = "share/zsh/site-functions";
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];

      shellAliases = {
        v = "nvim";
        vi = "nvim";
        cls = "clear";
        ls = "eza --color=always --icons";
        l = "eza -l --icons";
        la = "eza -la --icons";
        lla = "eza -la --icons";
        lt = "eza --tree --icons";
        cat = "bat -p";
        rcat = "/bin/cat";
        grep = "grep --color=auto";
        df = "df -h";
        du = "du -h";
        cp = "cp -iv";
        mv = "mv -iv";
        mkdir = "mkdir -pv";
        cd = "z";
        cdi = "zi";
        path = "print -l $path";

        zshconf = "nano ${host.dotfilesDirectory}/modules/home/shell/default.nix";
        ghosttyconf = "nano ${host.dotfilesDirectory}/modules/home/terminal/ghostty.conf";
      };

      initContent = ''
        reload() {
          unset __HM_SESS_VARS_SOURCED __HM_ZSH_SESS_VARS_SOURCED
          export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
          exec /bin/zsh -l
        }

        unalias zi 2>/dev/null || true
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

        export BAT_THEME="base16"
      '';
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings.enter_accept = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidget.command = "fd --type f --hidden --follow --exclude .git";
      changeDirWidget.command = "fd --type d --hidden --follow --exclude .git";
      historyWidget.command = "";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = false;
    };
  };
}
