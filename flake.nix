{
  # https://github.com/anotherhadi/nixy
  description = ''
    Nixy simplifies and unifies the Hyprland ecosystem with a modular, easily customizable setup.
    It provides a structured way to manage your system configuration and dotfiles with minimal effort.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    stylix.url = "github:danth/stylix";
    #apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    sops-nix.url = "github:Mic92/sops-nix";
    nixarr.url = "github:rasmus-kirk/nixarr";
    vicinae.url = "github:vicinaehq/vicinae";
    nvf.url = "github:notashelf/nvf";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eleakxir.url = "github:anotherhadi/eleakxir";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # Websites
    community-website = {
      url = "git+file:///home/kiri/dev/lab/community-website";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zentire-website = {
      url = "git+file:///home/kiri/dev/lab/zentire-new";
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

            ./hosts/polaris/configuration.nix
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

            ./hosts/altair/configuration.nix
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
            ./hosts/orion/configuration.nix
          ];
        };
      };
    };
}
