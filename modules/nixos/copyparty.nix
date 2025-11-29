{
  services = {
    copyparty = {
      enable = true;

      settings = {
        e2dsa = true;
        no-cfg = true;
      };
    };

    caddy.virtualHosts."files.jelles.net".extraConfig = "reverse_proxy :3923";
  };
}
