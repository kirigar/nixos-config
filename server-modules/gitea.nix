{ config, pkgs, ... }:
{
  services.gitea = {
    enable = true;
    appName = "Git Server"; # A name for your Gitea instance
    settings = {
      server = {
        PROTOCOL = "http"; # Use http for now, caddy will handle https
        DOMAIN = "git.jelles.net";
        ROOT_URL = "https://git.jelles.net/";
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3001;
        DISABLE_SSH = true; # Disable the built-in SSH server, use HTTPS for cloning
      };

      service = {
        DISABLE_REGISTRATION = true; # Consider enabling for public instances
      };
    };
  };

  services.caddy.virtualHosts."git.jelles.net".extraConfig = "reverse_proxy :3001";
}
