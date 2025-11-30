{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = [
      config.sops.secrets.ssh_config_orion.path
    ];
  };
}
