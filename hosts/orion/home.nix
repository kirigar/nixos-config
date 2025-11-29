{
  pkgs,
  config,
  ...
}:
{
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../modules/home-manager/shell
    ../../modules/home-manager/git.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Utils
      btop

      # Provide relevant terminfo
      kitty
      ghostty
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
