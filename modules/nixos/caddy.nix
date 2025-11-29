{
  inputs,
  pkgs,
  config,
  ...
}:
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

    email = config.var.email;
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
  };
}
