{ config, pkgs, ... }:
{
  imports = [
    ../variables.nix
    ./shell
    ./git.nix
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    NUGET_PACKAGES = "${config.xdg.dataHome}/nuget";
    W3M_DIR = "${config.xdg.dataHome}/w3m";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    download = "${config.home.homeDirectory}/download";

    music = "${config.home.homeDirectory}/media/music";
    pictures = "${config.home.homeDirectory}/media/images";
    videos = "${config.home.homeDirectory}/media/videos";

    desktop = "${config.xdg.dataHome}/desktop";
    documents = "${config.xdg.dataHome}/documents";
    publicShare = "${config.xdg.dataHome}/public";
    templates = "${config.xdg.dataHome}/templates";
  };
}
