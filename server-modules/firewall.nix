# Firewall configuration for NixOS
{
  networking.firewall = {
    enable = true;
    allowPing = false;
  };

  networking.nftables.enable = true;
}
