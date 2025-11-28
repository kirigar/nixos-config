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
    #../../home/programs/nvf
    ../../home/programs/shell
    #../../home/programs/fetch
    ../../home/programs/git
    #../../home/programs/lazygit

    # Scripts
    #../../home/scripts # All scripts
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
