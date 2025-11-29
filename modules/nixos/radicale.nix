{
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ "127.0.0.1:5232" ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/var/lib/radicale/users";
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  };

  services.caddy.virtualHosts."radicale.jelles.net".extraConfig = ''
    reverse_proxy :5232 {
       header_up X-Script-Name /
       header_up X-Forwarded-For {remote}
       header_up X-Remote-User {http.auth.user.id}
    }'';
}
