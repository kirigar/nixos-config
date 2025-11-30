{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./common.nix
    ../../secrets

    # Programs
    ./accounts
    ./nixCats

    ./aerc.nix
    ./bitwarden.nix
    ./direnv.nix
    ./discord.nix
    ./ghostty.nix
    ./gpg.nix
    ./khal.nix
    ./kitty.nix
    ./lazygit.nix
    ./nh.nix
    ./rclone.nix
    ./spicetify.nix
    ./ssh.nix
    ./thunar.nix
    ./thunderbird.nix
    ./todoman.nix
    ./vicinae.nix
    ./zathura.nix

    # Scripts
    ./scripts

    # System (Desktop environment like stuff)
    ./hyprland
    ./hyprpanel.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./mime.nix
    ./udiskie.nix
  ];

  home = {
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

      libreoffice-qt6-fresh
    ];
  };
}
