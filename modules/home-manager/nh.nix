{config, ...}: {
  programs.nh = {
    enable = true;
    flake = config.var.configDirectory; # Assuming this is the flake root
  };
}
