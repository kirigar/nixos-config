{ config, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./audio.nix
    ./bluetooth.nix
    ./fonts.nix
    ./sddm.nix
    ./hyprland.nix
    ./printing.nix
    ./systemd-boot.nix
    ./syncthing.nix
  ];
}
