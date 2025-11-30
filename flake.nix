{
  # https://github.com/anotherhadi/nixy
  description = ''
    Nixy simplifies and unifies the Hyprland ecosystem with a modular, easily customizable setup.
    It provides a structured way to manage your system configuration and dotfiles with minimal effort.
  '';

  inputs = {
    # NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flakes
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Others
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.home-manager.follows = "home-manager";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Websites
    community-website = {
      url = "git+ssh://git@orion/kiri/community-website";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zentire-website = {
      url = "git+ssh://git@orion/kiri/zentire-website";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    {
      nixosConfigurations = {
        polaris = nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [ ];
              _module.args = {
                inherit inputs;
              };
            }
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix

            inputs.nixos-hardware.nixosModules.common-pc
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-gpu-amd

            ./hosts/polaris/system.nix
          ];
        };

        altair = nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [ ];
              _module.args = { inherit inputs; };
            }
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix

            inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-amdgpu

            ./hosts/altair/system.nix
          ];
        };

        orion = nixpkgs.lib.nixosSystem {
          #system = "x86_64-linux";
          modules = [
            {
              _module.args = {
                inherit inputs;
              };
            }

            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            inputs.copyparty.nixosModules.default

            inputs.disko.nixosModules.disko
            ./hosts/orion/system.nix
          ];
        };
      };
    };
}
