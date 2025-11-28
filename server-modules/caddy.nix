{ inputs, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts."community.jelles.net".extraConfig = ''
      root * ${inputs.community-website.packages.${pkgs.stdenv.hostPlatform.system}.default}
      file_server
    '';
    virtualHosts."zentire.jelles.net".extraConfig = ''
      root * ${inputs.zentire-website.packages.${pkgs.stdenv.hostPlatform.system}.default}
      file_server
    '';
    email = "mail@jelles.net";
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
  };
}
