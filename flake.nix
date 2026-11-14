{
  description = "yumx's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-go.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agent-skills-nix = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Skill sources (consumed by modules/home/agents/skills.nix)
    personal-skills = {
      url = "github:samuelyuma/agent-skills";
      flake = false;
    };
    agent-browser = {
      url = "github:vercel-labs/agent-browser";
      flake = false;
    };
    grill = {
      url = "github:mattpocock/skills";
      flake = false;
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
    tactile-design = {
      url = "github:kosta4a/tactile-design";
      flake = false;
    };
    emil-skills = {
      url = "github:emilkowalski/skills";
      flake = false;
    };
    security-audit-skill = {
      url = "github:cloudflare/security-audit-skill";
      flake = false;
    };
    # Package source (consumed by pkgs/).
    rtk = {
      url = "github:rtk-ai/rtk/v0.48.0";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      sops-nix,
      nixvim,
      agent-skills-nix,
      ...
    }:
    let
      hosts = import ./flake/hosts.nix;
      inherit (hosts)
        darwin
        linux
        ;

      darwinPkgs = nixpkgs.legacyPackages.${darwin.system};
      linuxPkgs = nixpkgs.legacyPackages.${linux.system};

      localChecks = pkgs: host: import ./flake/git-hooks.nix { inherit inputs pkgs host; };

      activate = import ./flake/activate.nix {
        inherit inputs;
        pkgs = darwinPkgs;
        host = darwin;
        inherit self;
      };

      mkPackages = host: pkgs: {
        nxc = pkgs.callPackage ./pkgs/nxc {
          repo = "${host.homeDirectory}/nix-config";
          hostName = host.name;
          isLinux = host.profile == "linux";
          homeManager = inputs.home-manager.packages.${host.system}.home-manager;
        };
        opencode = pkgs.callPackage ./pkgs/opencode { };
        rtk = pkgs.callPackage ./pkgs/rtk.nix { src = inputs.rtk; };
      };
    in
    {
      formatter = {
        ${darwin.system} = darwinPkgs.nixfmt-tree;
        ${linux.system} = linuxPkgs.nixfmt-tree;
      };

      packages = {
        ${darwin.system} = (mkPackages darwin darwinPkgs) // {
          inherit activate;
          docker-credential-osxkeychain = darwinPkgs.callPackage ./pkgs/docker-credential-osxkeychain.nix { };
        };
        ${linux.system} = (mkPackages linux linuxPkgs) // {
          home-manager = inputs.home-manager.packages.${linux.system}.home-manager;
        };
      };

      apps.${darwin.system}.activate = {
        type = "app";
        program = "${activate}/bin/activate";
      };

      checks = {
        ${darwin.system} = {
          darwin = self.darwinConfigurations.darwin.system;
          hooks = localChecks darwinPkgs darwin;
          sops-activation-order =
            let
              dag = import (home-manager.outPath + "/modules/lib/dag.nix") { inherit (darwinPkgs) lib; };
              activation =
                self.darwinConfigurations.darwin.config.home-manager.users.${darwin.username}.home.activation;
              order = map (entry: entry.name) (dag.topoSort activation).result;
              index = name: darwinPkgs.lib.lists.findFirstIndex (entry: entry == name) null order;
            in
            assert index "setupLaunchAgents" < index "sops-nix";
            darwinPkgs.runCommand "sops-activation-order" { } "touch $out";
        };

        ${linux.system} = {
          home-manager = self.homeConfigurations.linux.activationPackage;
        };
      };

      devShells = {
        ${darwin.system}.default = import ./flake/devshell.nix {
          pkgs = darwinPkgs;
          localChecks = localChecks darwinPkgs darwin;
        };
        ${linux.system}.default = import ./flake/devshell.nix {
          pkgs = linuxPkgs;
          localChecks = localChecks linuxPkgs linux;
        };
      };

      darwinConfigurations.darwin = nix-darwin.lib.darwinSystem {
        inherit (darwin) system;
        specialArgs = {
          host = darwin;
          inherit inputs;
        };
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          sops-nix.darwinModules.sops
          {
            home-manager = {
              backupFileExtension = "hm-backup";
              extraSpecialArgs = {
                host = darwin;
                inherit inputs;
              };
              sharedModules = [
                nixvim.homeModules.nixvim
                sops-nix.homeManagerModules.sops
                agent-skills-nix.homeManagerModules.default
              ];
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${darwin.username} = import ./modules/home;
            };
          }
        ];
      };

      homeConfigurations.linux = home-manager.lib.homeManagerConfiguration {
        pkgs = linuxPkgs;
        extraSpecialArgs = {
          host = linux;
          inherit inputs;
        };
        modules = [
          nixvim.homeModules.nixvim
          sops-nix.homeManagerModules.sops
          agent-skills-nix.homeManagerModules.default
          ./hosts/linux
        ];
      };
    };
}
