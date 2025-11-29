{config, ...}: {
  programs.nh = {
    enable = true;
    flake = "/home/kiri/.config/nixos"; # Assuming this is the flake root
  };
}
