{
  config,
  lib,
  ...
}:
let
  username = config.var.username;
  hostname = config.var.hostname;
  isOrion = hostname == "orion";

  # On desktops, sync to home directory. On server, sync to filebrowser storage.
  syncPath = if isOrion then "/var/lib/filebrowser/files" else "/home/${username}/sync";
  group = if isOrion then "filebrowser" else "users";
in
{
  # 1. Firewall rules for synchronization
  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };

  # 3. Syncthing Service Configuration
  services.syncthing = {
    enable = true;

    user = username;
    group = group;

    overrideDevices = true; # Overrides any devices added via Web UI
    overrideFolders = true; # Overrides any folders added via Web UI

    settings = {
      devices = config.var.syncthing.devices;

      folders = {
        "sync" = {
          path = syncPath;
          devices = builtins.attrNames config.var.syncthing.devices; # Share with all defined devices
          # Ensure new files are readable by the group (chmod 770 approx)
          ignorePerms = true;
        };
      };

      gui = {
        # access the GUI on localhost:8384
        theme = "black";
      };
    };
  };

  # 4. Permission Hardening for Orion
  # Force syncthing to write files with group-write permissions (007 umask = 770 perms)
  systemd.services.syncthing.serviceConfig.UMask = lib.mkIf isOrion "0007";

  systemd.tmpfiles.rules = [
    "d /var/lib/syncthing 0700 ${username} ${group} -"
  ];
}
