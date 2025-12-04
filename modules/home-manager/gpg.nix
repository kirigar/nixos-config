{
  config,
  pkgs,
  ...
}:
{
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentry = {
      package = pkgs.pinentry-gnome3;
    };
    sshKeys = [
      "CD848796822630B280FC6DFA55F24A20040F22B5"
      "B8FBDFBD7F42C444C17E086E0EE2E34FB43A7187"
    ];
  };
}
