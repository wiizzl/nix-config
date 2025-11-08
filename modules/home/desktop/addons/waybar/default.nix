{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.waybar = {
    enable = mkEnableOption "Waybar status bar";
  };

  config = mkIf desktop.addons.waybar.enable {
    home-manager.users.${user.name} = {
      wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ];

      programs.waybar = {
        enable = true;

        settings = {
          mainBar = {
            layer = "top";
            position = "left";
            output = [ "DP-2" ];

            margin-top = 8;
            margin-bottom = 8;
            margin-right = 0;
            margin-left = 8;

            spacing = 4;

            modules-left = [
              "image#nixos"
              "custom/sep"
              "hyprland/workspaces"
            ];
            modules-right = [
              "tray"
              "custom/sep"
              "pulseaudio"
              "custom/sep"
              # "bluetooth"
              # "custom/sep"
              "network"
              # "custom/sep"
              # "cpu"
              # "custom/sep"
              # "memory"
              # "custom/sep"
              # "disk"
              "custom/sep"
              "battery"
              "custom/sep"
              "clock"
            ];

            network = {
              format = "{ifname}";
              format-wifi = "{icon}";
              format-ethernet = "";
              format-disconnected = "󰤭";
              format-icons = [
                "󰤟"
                "󰤢"
                "󰤥"
                "󰤨"
              ];
              tooltip-format = "{ifname} via {gwaddr}";
              tooltip-format-wifi = "{essid} ({signalStrength}%)";
              tooltip-format-ethernet = "{ifname}";
              tooltip-format-disconnected = "Disconnected";
            };

            "image#nixos" = {
              path = "${pkgs.nixos-icons}/share/icons/hicolor/24x24/apps/nix-snowflake-white.png";
              size = 24;
              on-click = "swaync-client -t -sw";
            };

            pulseaudio = {
              format = "";
              tooltip-format = "{volume}%";
              format-muted = "";
              on-click = "pavucontrol";
            };

            "hyprland/workspaces" = {
              format = "{name}";
              disable-scroll = true;
              warp-on-scroll = false;
            };

            tray = {
              spacing = 10;
              reverse-direction = true;
            };

            clock = {
              tooltip-format = "{:%d/%m/%Y}";
            };

            battery = {
              states = {
                good = 95;
                warning = 30;
                critical = 15;
              };
              format = "Bat: {capacity}% {icon} {time}";
              format-plugged = "{capacity}% ";
              format-alt = "Bat {capacity}%";
              format-time = "{H}:{M}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };

            "custom/sep" = {
              format = "――";
              interval = 0;
              tooltip = false;
            };
          };
        };

        style =
          # let
          # colors = config.lib.stylix.colors;
          # hex = base: "#${base}";
          # in
          ''
            window#waybar {
              border-radius: 8px;
              color: #cdd6f4;
              border: 1px solid #313244;
            }

            #workspaces button {
              padding: 0;
              color: #89b4fa;
              background: transparent;
              border-bottom: 3px solid transparent;
            }

            #workspaces button.active {
              color: #89b4fa;
              border-bottom: 3px solid #cba6f7;
            }

            #workspaces button.empty {
              color: #cdd6f4;
            }

            #workspaces button.urgent {
              background-color: #f38ba8;
            }

            #custom-sep {
              color: #585b70;
            }
          '';
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.waybar.enable = false;
    };
  };
}
