{ config, pkgs, ... }:

{
  services.actual = {
    enable = true;
    openFirewall = false;
    settings = {
      port = 3000;
      hostname = "127.0.0.1"; # Listen on all IPv4 addresses
    };
  };

  services.caddy.virtualHosts."finance.jelles.net".extraConfig = "reverse_proxy :3000";
}
