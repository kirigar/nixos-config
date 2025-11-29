{ modulesPath, config, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")

    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix

    ../../server-modules/ssh.nix
    ../../server-modules/caddy.nix
    ../../server-modules/bitwarden.nix
    ../../server-modules/firewall.nix
    ../../server-modules/copyparty.nix
    ../../server-modules/home-assistant.nix
    ../../server-modules/glance.nix
    ../../server-modules/radicale.nix
    ../../server-modules/actual-budget.nix

    ./disk-config.nix
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}
