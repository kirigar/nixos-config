{
  config,
  pkgs,
  ...
}:
{
  programs.rclone = {
    enable = true;

    # Give rclone access to the ssh agent
    package = pkgs.writeShellScriptBin "rclone" ''
      export GNUPGHOME="${config.xdg.dataHome}/gnupg"
      export SSH_AUTH_SOCK=$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)
      exec ${pkgs.rclone}/bin/rclone "$@"
    '';

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
              dir-cache-time = "5m";
              poll-interval = "10s";
            };
          };
        };
      };

      orion = {
        config = {
          type = "sftp";
          user = config.var.username;
        };

        secrets = {
          host = config.sops.secrets.orion_ip.path;
        };

        mounts = {
          "/var/lib/filebrowser/files" = {
            enable = true;

            mountPoint = "${config.home.homeDirectory}/orion";

            options = {
              dir-cache-time = "5m";
              poll-interval = "10s";
              # Network optimizations
              "buffer-size" = "32M";
              "vfs-read-chunk-size" = "32M";
            };
          };
        };
      };
    };
  };
}
