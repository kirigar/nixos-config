{ config, pkgs, ... }:
let
  calendarsPath = "${config.xdg.dataHome}/calendars";
in
{
  programs.pimsync.enable = true;
  services.pimsync.enable = true;

  systemd.user.tmpfiles.rules = [
    "d ${calendarsPath} 0700 - - - -"
    "d ${calendarsPath}/radicale 0700 - - - -"
    "d ${calendarsPath}/university 0700 - - - -"
  ];

  accounts.calendar = {
    basePath = calendarsPath;
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
            config.sops.secrets.radicale_pass.path
          ];
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
                    config.sops.secrets.university_calendar_url.path
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
      };
    };
  };
}
