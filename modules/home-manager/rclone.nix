{ config, ... }:
{
  programs.rclone = {
    enable = true;
    remotes = {
      gdrive = {
        config = {
          type = "drive";
          scope = "drive";

          root_folder_id = "";
        };

        secrets = {
          token = "${config.xdg.configHome}/rclone/gdrive_token";

          client_id = "${config.xdg.configHome}/rclone/gdrive_client_id";
          client_secret = "${config.xdg.configHome}/rclone/gdrive_client_secret"; # TODO: sops?
        };

        mounts = {
          "/" = {
            enable = true;
            mountPoint = "${config.home.homeDirectory}/gdrive";

            options = {
              dir-cache-time = "5000h";
              poll-interval = "10s";
              vfs-cache-mode = "full";
            };
          };
        };
      };
    };
  };
}
