{ config, lib, ... }:

let
  inherit (lib) mkIf mkForce optionals;
  inherit (config.my) desktop system user;
in
{
  config = mkIf desktop.hyprland.enable {
    home-manager.users.${user.name} = {
      wayland.windowManager.hyprland = {
        enable = true;

        package = mkForce null;
        portalPackage = mkForce null;

        plugins = [ ]; # TODO: Add plugins like hyprexpo, ...

        systemd.variables = [ "--all" ];

        settings = {
          "$mod" = "SUPER";
          "misc:middle_click_paste" = false;

          monitor = [
            "DP-2, 1920x1080@164.92, 0x0, 1"
            "HDMI-A-2, 1920x1200@59.95, auto-center-left, 1, transform, 1"
          ];

          animations = {
            enabled = true;

            bezier = [
              "default, 0.12, 0.92, 0.08, 1.0"
            ];

            animation = [
              "windows, 1, 6, default, slide"
              "border, 1, 6, default"
              "borderangle, 1, 6, default"
              "fade, 1, 6, default"
              "workspaces, 1, 6, default, slidevert"
            ];
          };

          exec-once = [
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
          ];

          bind = [
            # Run applications
            "$mod, Return, exec, foot"
            "$mod, E, exec, thunar"
            "$mod, B, exec, zen-beta"

            # Rofi
            "$mod, D, exec, rofi -show drun"
            "$mod Shift, E, exec, rofi -modi 'emoji:rofimoji --action copy --skin-tone neutral --max-recent 0' -show emoji"
            "$mod, C, exec, cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"
            "$mod Shift, C, exec, rofi -modi calc -show calc -no-show-match -no-bold -no-sort -automatic-save-to-history"

            # Window management
            "$mod, Z, togglefloating"
            "$mod, F, fullscreen"
            "$mod, P, pseudo"
            "$mod, W, togglesplit"

            # Kill focused window
            "$mod, Q, killactive"
            "Alt, F4, killactive"

            # Groups
            "$mod, G, togglegroup"
            "$mod Alt, H, changegroupactive, b"
            "$mod Alt, L, changegroupactive, f"

            # Move focus
            "ALT, Tab, cyclenext"
            "$mod, H, movefocus, l"
            "$mod, L, movefocus, r"
            "$mod, K, movefocus, u"
            "$mod, J, movefocus, d"

            # Swap windows
            "$mod Shift, H, movewindow, l"
            "$mod Shift, L, movewindow, r"
            "$mod Shift, K, movewindow, u"
            "$mod Shift, J, movewindow, d"

            # Switch to a different workspaces
            "$mod, ampersand, workspace, 1"
            "$mod, eacute, workspace, 2"
            "$mod, quotedbl, workspace, 3"
            "$mod, apostrophe, workspace, 4"
            "$mod, parenleft, workspace, 5"
            "$mod, minus, workspace, 6"
            "$mod, egrave, workspace, 7"
            "$mod, underscore, workspace, 8"
            "$mod, ccedilla, workspace, 9"
            "$mod, agrave, workspace, 10"

            # Move focused window to workspace silently
            "$mod Shift, ampersand, movetoworkspacesilent, 1"
            "$mod Shift, eacute, movetoworkspacesilent, 2"
            "$mod Shift, quotedbl, movetoworkspacesilent, 3"
            "$mod Shift, apostrophe, movetoworkspacesilent, 4"
            "$mod Shift, parenleft, movetoworkspacesilent, 5"
            "$mod Shift, minus, movetoworkspacesilent, 6"
            "$mod Shift, egrave, movetoworkspacesilent, 7"
            "$mod Shift, underscore, movetoworkspacesilent, 8"
            "$mod Shift, ccedilla, movetoworkspacesilent, 9"
            "$mod Shift, agrave, movetoworkspacesilent, 10"

            # Move focused window to workspace
            "$mod Alt, ampersand, movetoworkspace, 1"
            "$mod Alt, eacute, movetoworkspace, 2"
            "$mod Alt, quotedbl, movetoworkspace, 3"
            "$mod Alt, apostrophe, movetoworkspace, 4"
            "$mod Alt, parenleft, movetoworkspace, 5"
            "$mod Alt, minus, movetoworkspace, 6"
            "$mod Alt, egrave, movetoworkspace, 7"
            "$mod Alt, underscore, movetoworkspace, 8"
            "$mod Alt, ccedilla, movetoworkspace, 9"
            "$mod Alt, agrave, movetoworkspace, 10"

            # Scroll trough workspaces with mod + scroll
            "$mod, mouse_down, workspace, e-1"
            "$mod, mouse_up, workspace, e+1"

            # Special workspaces
            # "$mod Alt, X, movetoworkspace, special"
            "$mod Alt, X, movetoworkspace, e+0"
            "$mod Shift, X, movetoworkspacesilent, special"
            "$mod, X, togglespecialworkspace"

            # Capture
            "$mod Shift, P, exec, hyprpicker -adln"
            "$mod Shift, S, exec, hyprshot --mode region --freeze --output-folder ~/Pictures/Screenshots/"
          ];

          bindm = [
            # Move/resize windows with mod + LMB/RMB and dragging
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          binde = [
            # Resize windows
            "$mod Ctrl, H, resizeactive, -30 0"
            "$mod Ctrl, L, resizeactive, 30 0"
            "$mod Ctrl, J, resizeactive, 0 -30"
            "$mod Ctrl, K, resizeactive, 0 30"
          ];

          # Multimedia keys for volume and LCD brightness (fallback)
          bindel =
            optionals desktop.addons.swayosd.enable [
              ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
              ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
              ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
              ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
              ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
              ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
            ]
            ++ optionals (!desktop.addons.swayosd.enable) [
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

          input = {
            kb_layout = system.locale.keymap;
            follow_mouse = 1;
            sensitivity = 0;

            repeat_rate = 35;
            repeat_delay = 250;

            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              scroll_factor = 0.8;
            };
          };

          cursor = {
            inactive_timeout = 30;
            no_hardware_cursors = true;
          };

          device = {
            name = "logitech-usb-receiver";
            sensitivity = -0.7;
          };

          gesture = [ "3, horizontal, workspace" ];

          general = {
            gaps_in = 3;
            gaps_out = 8;

            border_size = 2;
            resize_on_border = false;

            allow_tearing = false;

            layout = "dwindle";
          };

          decoration = {
            rounding = 8;
            rounding_power = 2;

            active_opacity = 0.85;
            inactive_opacity = 0.8;
            fullscreen_opacity = 0.9;

            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
            };

            blur = {
              enabled = true;
              xray = true;
              special = false;
              new_optimizations = true;
              size = 14;
              passes = 4;
              brightness = 1;
              noise = 0.01;
              contrast = 1;
              popups = true;
              popups_ignorealpha = 0.6;
              ignore_opacity = false;
            };
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
            smart_split = false;
            default_split_ratio = 1.0;
            special_scale_factor = 0.9;
            single_window_aspect_ratio = "0 0";
            force_split = 2; # 0 = follow mouse | 1 = left | 2 = right
          };

          master = {
            new_status = "master";
          };

          misc = {
            force_default_wallpaper = -1;
            disable_hyprland_logo = true;
          };

          windowrule = [
            # Ignore maximize requests from apps.
            "suppressevent maximize, class:.*"

            # Fix some dragging issues with XWayland
            "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
          ];

          workspace = [
            "1, monitor:DP-2, default:true, persistent:true"
            "2, monitor:DP-2, persistent:true"
            "3, monitor:DP-2, persistent:true"
            "4, monitor:DP-2, persistent:true"
            "5, monitor:DP-2, persistent:true"
            "6, monitor:DP-2, persistent:true"
            "7, monitor:DP-2, persistent:true"
            "8, monitor:DP-2, persistent:true"
            "9, monitor:DP-2"
            "10, monitor:DP-2"
            "20, monitor:HDMI-A-2, default:true, persistent:true, gapsout:0, border:false, rounding:false, decorate:false, shadow:false"
          ];
        };
      };
    };
  };
}
