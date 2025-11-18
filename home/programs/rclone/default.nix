{
  programs.rclone = {
    enable = true;
    remotes = {
      drive = {
        config = {
          type = "drive";
        };
      };
    };
  };
}
