# Misc
{
  pkgs,
  config,
  ...
}:
let
  hostname = config.var.hostname;
  keyboardLayout = config.var.keyboardLayout;
  configDir = config.var.configDirectory;
  timeZone = config.var.timeZone;
  defaultLocale = config.var.defaultLocale;
  otherLocale = config.var.otherLocale;
  numericLocale = config.var.numericLocale;
  timeLocale = config.var.timeLocale;
  autoUpgrade = config.var.autoUpgrade;
in
{
  networking.hostName = hostname;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # system.autoUpgrade = {
  #   enable = autoUpgrade;
  #   dates = "04:00";
  #   flake = "${configDir}";
  #   flags = [
  #     "--update-input"
  #     "nixpkgs"
  #     "--commit-lock-file"
  #   ];
  #   allowReboot = false;
  # };

  time = {
    timeZone = timeZone;
  };
  i18n.defaultLocale = defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = otherLocale;
    LC_IDENTIFICATION = otherLocale;
    LC_MEASUREMENT = otherLocale;
    LC_MONETARY = numericLocale;
    LC_NAME = otherLocale;
    LC_NUMERIC = numericLocale;
    LC_PAPER = otherLocale;
    LC_TELEPHONE = otherLocale;
    LC_TIME = timeLocale;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = keyboardLayout;
      xkb.variant = "";
    };
    # gnome.gnome-keyring.enable = true;
    # psd = {
    #   enable = true;
    #   resyncTimer = "10m";
    # };
  };
  console.keyMap = keyboardLayout;

  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
    BROWSER = "brave";
  };

  services.libinput.enable = true;
  programs.dconf.enable = true;
  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [
        gcr
        gnome-settings-daemon
      ];
    };
    gvfs.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
  };

  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = [ "/share/zsh" ];

  # Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = true;
    man.enable = true;
    dev.enable = true;
    info.enable = true;
    nixos.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprland-qtutils
    xdg-utils
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";

    # userland niceness
    rtkit.enable = true;

    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
  };
}
