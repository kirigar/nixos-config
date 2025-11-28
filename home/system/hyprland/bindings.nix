{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod, return, exec, uwsm app -- ${pkgs.kitty}/bin/kitty" # Ghostty (terminal)
      #"$mod,E, exec,  uwsm app -- ${pkgs.xfce.thunar}/bin/thunar" # Thunar
      "$mod, b, exec,  uwsm app -- ${pkgs.brave}/bin/brave" # Brave Browser
      "$mod, m, exec,  uwsm app -- ${pkgs.thunderbird}/bin/thunderbird" # Proton Mail
      #"$mod,L, exec,  uwsm app -- ${pkgs.hyprlock}/bin/hyprlock" # Lock
      "$mod, space, exec, vicinae toggle" # Launcher FIXME: broken
      #"$mod,X, exec, powermenu" # Powermenu
      #"$mod, space, exec, menu" # Launcher

      "$shiftMod, space, exec, hyprfocus-toggle" # Toggle HyprFocus

      "$mod, q, killactive," # Close window
      "$mod, t, togglefloating," # Toggle Floating
      "$mod, f, fullscreen" # Toggle Fullscreen

      "$mod, j, layoutmsg, cyclenext" # Move focus Down
      "$mod, k, layoutmsg, cycleprev" # Move focus Up
      "$altMod, j, layoutmsg, swapnext" # Move focus Down
      "$altMod, k, layoutmsg, swapprev" # Move focus Up

      "$mod, x, focusmonitor, +1" # Focus next monitor
      "$altMod, x, movewindow, mon:+1"
      "$altMod, h, layoutmsg, addmaster" # Add to master
      "$altMod, l, layoutmsg, removemaster" # Remove from master

      "$mod, print, exec, screenshot region" # Screenshot region
      ", PRINT, exec, screenshot monitor" # Screenshot monitor

      "$mod, w, workspace, 1"
      "$mod, e, workspace, 2"
      "$mod, r, workspace, 3"
      "$mod, i, workspace, 11"
      "$mod, o, workspace, 12"
      "$mod, p, workspace, 13"

      "$altMod, w, movetoworkspace, 1"
      "$altMod, e, movetoworkspace, 2"
      "$altMod, r, movetoworkspace, 3"
      "$altMod, i, movetoworkspace, 11"
      "$altMod, o, movetoworkspace, 12"
      "$altMod, p, movetoworkspace, 13"

      "$mod, z, togglespecialworkspace, scratchpad"
    ];

    bindm = [
      "$mod, mouse:272, movewindow" # Move Window (mouse)
      "$mod, mouse:274, resizewindow" # Resize Window (mouse)
    ];

    binde = [
      "$mod, h, layoutmsg, mfact -0.01" # Move focus left
      "$mod, l, layoutmsg, mfact +0.01" # Move focus Right
    ];

    bindl = [
      ",XF86AudioMute, exec, sound-toggle" # Toggle Mute
      ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # Play/Pause Song
      ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next" # Next Song
      ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous" # Previous Song
      ",switch:Lid Switch, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock when closing Lid
    ];

    bindle = [
      ",XF86AudioRaiseVolume, exec, sound-up" # Sound Up
      ",XF86AudioLowerVolume, exec, sound-down" # Sound Down
      ",XF86MonBrightnessUp, exec, brightness-up" # Brightness Up
      ",XF86MonBrightnessDown, exec, brightness-down" # Brightness Down
    ];
  };
}
