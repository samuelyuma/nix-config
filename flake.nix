{
  description = "yumx's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    ponytail = {
      url = "github:DietrichGebert/ponytail";
      flake = false;
    };
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
    i-have-adhd = {
      url = "github:ayghri/i-have-adhd";
      flake = false;
    };
    humanizer = {
      url = "github:blader/humanizer";
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
      host = import ./flake/hosts.nix;
      pkgs = nixpkgs.legacyPackages.${host.system};
      localChecks = import ./flake/git-hooks.nix { inherit inputs pkgs host; };
      activate = import ./flake/activate.nix {
        inherit
          inputs
          pkgs
          host
          self
          ;
      };
    in
    {
      formatter.${host.system} = pkgs.nixfmt-tree;
      packages.${host.system} = {
        inherit activate;
        docker-credential-osxkeychain = pkgs.callPackage ./pkgs/docker-credential-osxkeychain.nix { };
        opencode = pkgs.callPackage ./pkgs/opencode { };
        rtk = pkgs.callPackage ./pkgs/rtk.nix { src = inputs.rtk; };
        workshop-runner = pkgs.callPackage ./pkgs/workshop-runner.nix { };
      };
      apps.${host.system}.activate = {
        type = "app";
        program = "${activate}/bin/activate";
      };
      checks.${host.system} = {
        darwin = self.darwinConfigurations.darwin.system;
        hooks = localChecks;
      };
      devShells.${host.system}.default = import ./flake/devshell.nix { inherit pkgs localChecks; };
      darwinConfigurations.darwin = nix-darwin.lib.darwinSystem {
        inherit (host) system;
        specialArgs = { inherit host inputs; };
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          sops-nix.darwinModules.sops
          {
            home-manager = {
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit host inputs; };
              sharedModules = [
                nixvim.homeModules.nixvim
                sops-nix.homeManagerModules.sops
                agent-skills-nix.homeManagerModules.default
              ];
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${host.username} = import ./modules/home;
            };
          }
        ];
      };
    };
}
