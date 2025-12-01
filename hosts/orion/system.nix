{ modulesPath, config, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")

    ../../modules/nixos/common.nix

    ../../modules/nixos/ssh.nix
    ../../modules/nixos/caddy.nix
    ../../modules/nixos/bitwarden.nix
    ../../modules/nixos/firewall.nix
    ../../modules/nixos/filebrowser.nix
    ../../modules/nixos/home-assistant.nix
    ../../modules/nixos/glance.nix
    ../../modules/nixos/radicale.nix
    ../../modules/nixos/actual-budget.nix
    ../../modules/nixos/gitea.nix

    ./disk-config.nix
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
