{ config, ... }:
let
  storageRoot = "/var/lib/filebrowser/files";
in
{
  services.filebrowser = {
    enable = true;

    settings = {
      port = 9876;
      branding.name = "Jelle's Files";
    };
  };

  services.caddy.virtualHosts."files.jelles.net".extraConfig = ''
    reverse_proxy :${toString config.services.filebrowser.settings.port}
  '';
}
