{
  config,
  pkgs,
  lib,
  ...
}:
let
  storageRoot = "/var/lib/filebrowser/files";
  publishDirName = "_publish";

  processorScript = pkgs.writeShellScriptBin "process-docs" ''
    SRC_ROOT="${storageRoot}"
    OUT_ROOT="${storageRoot}/${publishDirName}"

    # Function to compile a single file
    compile_file() {
      local file="$1"
      # Remove SRC_ROOT prefix to get relative path
      local rel_path="''${file#$SRC_ROOT/}"
      # Construct target path (swap extension to .pdf)
      local target="$OUT_ROOT/''${rel_path%.*}.pdf"
      local target_dir
      target_dir=$(${pkgs.coreutils}/bin/dirname "$target")

      echo "Processing: $rel_path"
      ${pkgs.coreutils}/bin/mkdir -p "$target_dir"

      echo "Debug: Checking font visibility..."
      typst fonts

      if [[ "$file" == *.md ]]; then
        pandoc "$file" -o "$target" --pdf-engine=typst -V mainfont="Libertinus Serif"
      elif [[ "$file" == *.typ ]]; then
        typst compile "$file" "$target"
      fi

      # Ensure filebrowser can read the new file
      ${pkgs.coreutils}/bin/chown filebrowser:filebrowser "$target"
    }

    export -f compile_file
    export SRC_ROOT OUT_ROOT

    # 1. Initial Scan: Find all .md/.typ files not inside the export dir
    # and update them if the source is newer than the target
    ${pkgs.findutils}/bin/find "$SRC_ROOT" -type f \( -name "*.md" -o -name "*.typ" \) \
      -not -path "$SRC_ROOT/${publishDirName}/*" | while read -r file; do
        rel="''${file#$SRC_ROOT/}"
        tgt="$OUT_ROOT/''${rel%.*}.pdf"

        # Only compile if target doesn't exist or source is newer
        if [ ! -f "$tgt" ] || [ "$file" -nt "$tgt" ]; then
          compile_file "$file"
        fi
    done

    # 2. Watcher Mode
    echo "Starting watcher on $SRC_ROOT..."
    # --exclude matches the export dir to prevent infinite loops
    ${pkgs.inotify-tools}/bin/inotifywait -m -r -e close_write,moved_to \
      --exclude "${publishDirName}" \
      --format '%w%f' "$SRC_ROOT" | while read -r file; do
        if [[ "$file" == *.md ]] || [[ "$file" == *.typ ]]; then
           compile_file "$file"
        fi
    done
  '';

in
{

  imports = [
    ./fonts.nix
  ];

  services.filebrowser = {
    enable = true;

    settings = {
      root = storageRoot;
      port = 9876;
      branding.name = "Jelle's Files";
    };
  };

  services.caddy.virtualHosts."files.jelles.net".extraConfig = ''
    reverse_proxy :${toString config.services.filebrowser.settings.port}
  '';

  # Auto compile pdfs
  systemd.services.pdf-watcher = {
    description = "Auto-compile MD and Typst to PDF";
    after = [ "filebrowser.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "filebrowser";
      Group = "filebrowser";
      ExecStart = "${processorScript}/bin/process-docs";

      WorkingDirectory = storageRoot;
      Environment = [
        "HOME=/var/lib/filebrowser"
        "XDG_CACHE_HOME=/var/lib/filebrowser/.cache"
        # 3"TYPST_FONT_PATHS=${lib.makeSearchPath "share/fonts" fontPackages}"
      ];

      Restart = "always";
    };

    path = with pkgs; [
      typst
      pandoc
    ];
  };

  # Allow my user to access the filebrowser directory
  users.users."${config.var.username}".extraGroups = [ "filebrowser" ];

  systemd.services.filebrowser.serviceConfig = {
    UMask = lib.mkForce "0007";
  };

  systemd.tmpfiles.rules = [
    "Z /var/lib/filebrowser 0750 filebrowser filebrowser -" # Explicitly secure the data dir root
    "Z /var/lib/filebrowser/files 2770 filebrowser filebrowser -" # Sticky group on files
  ];
}
