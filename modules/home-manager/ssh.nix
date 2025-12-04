{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github-work" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/kiri/.ssh/github-work.pub";
        identitiesOnly = true;
      };
    };

    includes = [
      config.sops.secrets.ssh_config_orion.path
    ];
  };
}
