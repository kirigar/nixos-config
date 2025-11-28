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
          token = "/home/kiri/.config/rclone/gdrive_token";

          client_id = "/home/kiri/.config/rclone/gdrive_client_id";
          client_secret = "/home/kiri/.config/rclone/gdrive_client_secret"; #TODO: sops?
        };

        mounts = {
          "/" = {
            enable = true;
            mountPoint = "/home/kiri/gdrive";

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
