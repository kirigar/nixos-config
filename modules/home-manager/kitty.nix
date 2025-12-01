# Kitty is a fast, featureful, GPU based terminal emulator
{ config, lib, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      initial_window_width = 1200;
      initial_window_height = 600;
      update_check_interval = 0;
      enable_audio_bell = false;
      confirm_os_window_close = "0";
      remember_window_size = "no";
      disable_ligatures = "always";
      url_style = "curly";
      copy_on_select = "clipboard";
      cursor_shape = "Underline";
      cursor_underline_thickness = 3;
      window_padding_width = 10;
      open_url_with = "default";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/mykitty";
    };

    # Override stylix generated colorscheme by officially provided kitty colorscheme
    extraConfig = lib.mkAfter ''
      ## name: Kanagawa
      ## license: MIT
      ## author: Tommaso Laurenzi
      ## upstream: https://github.com/rebelot/kanagawa.nvim/

      background #1F1F28
      foreground #DCD7BA
      selection_background #2D4F67
      selection_foreground #C8C093
      url_color #72A7BC
      cursor #C8C093

      # Tabs
      active_tab_background #1F1F28
      active_tab_foreground #C8C093
      inactive_tab_background #1F1F28
      inactive_tab_foreground #727169
      #tab_bar_background #15161E

      # normal
      color0 #16161D
      color1 #C34043
      color2 #76946A
      color3 #C0A36E
      color4 #7E9CD8
      color5 #957FB8
      color6 #6A9589
      color7 #C8C093

      # bright
      color8 #727169
      color9 #E82424
      color10 #98BB6C
      color11 #E6C384
      color12 #7FB4CA
      color13 #938AA9
      color14 #7AA89F
      color15 #DCD7BA

      # extended colors
      color16 #FFA066
      color17 #FF5D62
    '';

  };
}
