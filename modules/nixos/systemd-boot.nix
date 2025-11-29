# Systemd-boot configuration for NixOS
{ pkgs, config, ... }:
{
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 5;

        extraInstallCommands = ''
          ENTRIES="${config.boot.loader.efi.efiSysMountPoint}/loader/entries"
          PROFILES="/nix/var/nix/profiles"

          for file in "$ENTRIES"/nixos-generation-*.conf; do
            generation=$(${pkgs.coreutils}/bin/basename "$file" | ${pkgs.gnugrep}/bin/grep -o -E '[0-9]+')
            timestamp=$(${pkgs.coreutils}/bin/stat -c %y "$PROFILES/system-$generation-link" 2>/dev/null | ${pkgs.coreutils}/bin/cut -d. -f1)

            if [ -z "$timestamp" ]; then
              timestamp="Unknown Date"
            fi

            ${pkgs.gnused}/bin/sed -i "s/^version .*/version Generation $generation - $timestamp/" "$file"
          done
        '';
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    # Silent boot
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  # To avoid systemd services hanging on shutdown
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
