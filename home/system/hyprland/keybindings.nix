{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    
    bind = [
      "$mod, Return, exec, kitty"
      "$mod, D, exec, rofi -show drun"
      "$mod, E, exec, dolphin"
      "$mod, Q, killactive"
      "$mod, V, togglefloating"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"

      # Move focus with mod + arrow keys
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Switch workspace with mod + [0-9]
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"

      # Move active windo to a workspace with mod + shift + [0-9]
      "$mod, SHIFT, 1, movetoworkspace, 1"
      "$mod, SHIFT, 2, movetoworkspace, 2"
      "$mod, SHIFT, 3, movetoworkspace, 3"
      "$mod, SHIFT, 4, movetoworkspace, 4"
      "$mod, SHIFT, 5, movetoworkspace, 5"
      "$mod, SHIFT, 6, movetoworkspace, 6"
      "$mod, SHIFT, 7, movetoworkspace, 7"
      "$mod, SHIFT, 8, movetoworkspace, 8"
      "$mod, SHIFT, 9, movetoworkspace, 9"

      # Special workspace
      # "$mod, S, togglespecialworkspace, magic"
      # "$mod, SHIFT, S, movetoworkspace, special:magic"

      # Scroll trough existing workspaces with mod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ];

    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
