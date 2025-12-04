{ config, ... }:
{
  imports = [
    ../../modules/nixos/desktop.nix

    ../../modules/nixos/ssh.nix
    ./hardware-configuration.nix
    ./variables.nix
  ];

  networking = {
    interfaces = {
      enp5s0 = {
        wakeOnLan.enable = true;
      };
    };
    firewall = {
      allowedUDPPorts = [ 9 ];
    };
  };

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
