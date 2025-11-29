{ config, pkgs, ... }:
{
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./users.nix
    ./utils.nix
    ../variables.nix
  ];
}