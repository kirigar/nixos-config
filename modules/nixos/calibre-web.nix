{
  services.calibre-web = {
    enable = true;
    listen.ip = "127.0.0.1";
    options = {
      enableBookUploading = true;
      calibreLibrary = "/var/lib/calibre-web/library";
      enableKepubify = true;
    };
  };

  services.caddy.virtualHosts."books.jelles.net".extraConfig = "reverse_proxy :8083";
}
