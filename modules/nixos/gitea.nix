{ config, pkgs, ... }:
{
  services.gitea = {
    enable = true;
    appName = "Git Server"; # A name for your Gitea instance

    user = "git";
    group = "git";

    settings = {
      server = {
        PROTOCOL = "http"; # Use http for now, caddy will handle https
        DOMAIN = "git.jelles.net";
        ROOT_URL = "https://git.jelles.net/";
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3001;

        START_SSH_SERVER = false;
        DISABLE_SSH = false; # Disable the built-in SSH server, use HTTPS for cloning
        SSH_PORT = 22;
      };

      service = {
        DISABLE_REGISTRATION = true; # Consider enabling for public instances
      };
    };
  };

  services.caddy.virtualHosts."git.jelles.net".extraConfig = "reverse_proxy :3001";

  users.users.git = {
    isSystemUser = true;
    description = "Gitea Service User";
    home = config.services.gitea.stateDir;
    createHome = true;
    homeMode = "750";
    useDefaultShell = true;
    group = "git";
  };

  users.groups.git = { };

  systemd.tmpfiles.rules = [
    "Z /var/lib/gitea 0750 git git - -"
  ];
}
