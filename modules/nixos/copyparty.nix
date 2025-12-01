{ config, ... }:
let
  username = config.var.username;
in
{
  services = {
    copyparty = {
      enable = true;

      settings = {
        e2dsa = true;
        no-cfg = true;
      };

      accounts = {
        "${username}" = {
          passwordFile = "/run/keys/copyparty-kiri-pass";
        };
      };

      groups = {
        "admin" = [ "${username}" ];
      };

      volumes = {
        "/public" = {
          path = "/var/lib/copyparty/public";

          access = {
            r = "*";
            rwmd = "@admin";
          };

          flags = {
            fk = 4;
            scan = 60;
          };
        };

        "/" = {
          path = "/var/lib/copyparty/private";
          access = {
            rwmd = "@admin";
          };
        };
      };
    };

    caddy.virtualHosts."files.jelles.net".extraConfig = "reverse_proxy :3923";
  };
}
