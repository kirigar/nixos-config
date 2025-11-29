{ config, pkgs, ... }:
{
  imports = [
    ../variables.nix
    ./shell
    ./git.nix
  ];
}
