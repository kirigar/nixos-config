{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    # Mostly user-specific configuration
    ./variables.nix
    ../../secrets

    # Programs
    ../../modules/home-manager/accounts
    ../../modules/home-manager/nixCats
    ../../modules/home-manager/shell

    ../../modules/home-manager/aerc.nix
    ../../modules/home-manager/bitwarden.nix
    ../../modules/home-manager/direnv.nix
    ../../modules/home-manager/discord.nix
    ../../modules/home-manager/ghostty.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/gpg.nix
    ../../modules/home-manager/khal.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/lazygit.nix
    ../../modules/home-manager/nh.nix
    ../../modules/home-manager/rclone.nix
    ../../modules/home-manager/spicetify.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/thunar.nix
    ../../modules/home-manager/thunderbird.nix
    ../../modules/home-manager/todoman.nix
    ../../modules/home-manager/vicinae.nix
    ../../modules/home-manager/zathura.nix

    # Scripts
    ../../modules/home-manager/scripts

    # System (Desktop environment like stuff)
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/hyprpanel.nix
    ../../modules/home-manager/hyprpaper.nix
    ../../modules/home-manager/mime.nix
    ../../modules/home-manager/udiskie.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      dotnet-runtime
      dafny

      gemini-cli

      # Apps
      bitwarden-desktop # Password manager
      vlc # Video player
      blanket # White-noise app
      obsidian # Note taking app
      planify # Todolists
      textpieces # Manipulate texts
      curtail # Compress images
      resources # Ressource monitor
      gnome-clocks # Clocks app
      gnome-text-editor # Basic graphic text editor
      mpv # Video player
      brave # Web browser

      # Privacy
      session-desktop # Session app, private messages
      signal-desktop # Signal app, private messages
      protonvpn-gui
      proton-pass
      proton-authenticator
      ticktick # Privacy friendly todo app

      # Utils
      zip
      unzip
      optipng
      jpegoptim
      pfetch
      btop
      fastfetch

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix

      # Backup
      vscode

      libreoffice-qt6-fresh
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
