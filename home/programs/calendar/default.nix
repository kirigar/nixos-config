{ config, pkgs, ... }:
{
  programs.khal = {
    enable = true;
    locale = {
      timeformat = "%H:%M";
      dateformat = "%m-%d";
    };
  };

  programs.pimsync.enable = true;
  services.pimsync.enable = true;

  accounts.calendar = {
    basePath = "${config.xdg.dataHome}/calendars";
    accounts = {
      "radicale" = {
        primary = true;
        primaryCollection = "personal";

        local = {
          type = "filesystem";
          fileExt = ".ics";
        };

        remote = {
          url = "https://radicale.jelles.net/";
          type = "caldav";
          userName = "kiri";
          # TODO: Bitwarden
          passwordCommand = [
            "${pkgs.coreutils}/bin/cat"
            "${config.xdg.configHome}/secrets/radicale_pass"
          ];
        };

        khal = {
          enable = true;
          type = "discover";
          color = "light blue";
        };

        pimsync = {
          enable = true;
          extraPairDirectives = [
            {
              name = "collections";
              params = [ "from b" ];
            }
          ];
        };
      };
      "university" = {
        remote = {
          type = "http";
        };

        local = {
          type = "filesystem";
          fileExt = ".ics";
        };

        pimsync = {
          enable = true;

          extraRemoteStorageDirectives = [
            {
              name = "collection_id";
              params = [ "events" ];
            }
            {
              name = "url";
              children = [
                {
                  name = "cmd";
                  params = [
                    "${pkgs.coreutils}/bin/cat"
                    "${config.xdg.configHome}/secrets/university_calendar_url"
                  ];
                }
              ];
            }
          ];
          extraPairDirectives = [
            {
              name = "collection";
              params = [ "events" ];
            }
          ];
        };
        khal = {
          enable = true;
          color = "#c72125";
        };
      };
    };
  };
}
