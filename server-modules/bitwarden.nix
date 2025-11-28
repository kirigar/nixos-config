# Bitwarden (or vaultwarden) is a self-hosted password manager.
{ config, ... }:
let
  domain = "vault.jelles.net";
in
{
  services = {
    vaultwarden = {
      enable = true;
      backupDir = "/var/backup/vaultwarden";
      config = {
        DOMAIN = "https://" + domain;
        SIGNUPS_ALLOWED = true;
        ROCKET_PORT = 8100;
        ROCKET_LOG = "critical";
      };
    };

    caddy.virtualHosts."vault.jelles.net".extraConfig =
      "reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT}";
  };

}
