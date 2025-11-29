# SSH configuration
{ config, ... }:
let
  username = config.var.username;
in
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      AllowUsers = [
        username
        "git"
      ];
    };
  };

  # Add my public SSH key to my user
  users.users."${username}" = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAU2LydkXRTtNFY7oyX8JQURwXLVhB71DeK8XzrXeFX1 openpgp:0xA490D93A"
    ];
  };
}
