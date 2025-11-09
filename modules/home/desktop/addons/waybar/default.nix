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
      wayland.windowManager.hyprland.settings.exec-once = mkIf desktop.hyprland.enable [ "waybar" ];

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

            width = 40;
            spacing = 0;

            modules-left = [
              "image#nixos"
              "clock#hours"
              "clock#minutes"
              "custom/sep"
            ];
            modules-center = [ "hyprland/workspaces" ];
            modules-right = [
              "tray"
              "custom/sep"
              "bluetooth"
              "network"
              "custom/notifications"
            ];

            "custom/notifications" = {
              format = "{icon}";
              format-icons = {
                notification = "󱅫";
                none = "󰂚";
                dnd-notification = "󰂛";
                dnd-none = "󰂛";
                inhibited-notification = "󱅫";
                inhibited-none = "󰂚";
                dnd-inhibited-notification = "󰂛";
                dnd-inhibited-none = "󰂛";
              };
              return-type = "json";
              exec-if = "which swaync-client";
              exec = "swaync-client -swb";
              on-click = "swaync-client -t -sw";
              on-click-right = "swaync-client -d -sw";
              tooltip = false;
            };

            network = {
              format = "{ifname}";
              format-wifi = "{icon}";
              format-ethernet = "󰈁";
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

            bluetooth = {
              format = "";
              on-click = "blueman-manager";
              format-connected = "󰂰";
              format-disabled = "󰂲";
              tooltip-format = "{controller_alias}\t{controller_address}";
              tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            };

            "image#nixos" = {
              path = "${pkgs.nixos-icons}/share/icons/hicolor/24x24/apps/nix-snowflake-white.png";
              size = 24;
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

            "clock#hours" = {
              format = "{:%H}";
              tooltip-format = "{:%d/%m/%Y}";
            };

            "clock#minutes" = {
              format = "{:%M}";
              tooltip-format = "{:%d/%m/%Y}";
            };

            battery = {
              states = {
                good = 80;
                warning = 30;
                critical = 10;
              };
              format = "{icon}";
              tooltip-format = "{capacity}% - {time}";
              format-plugged = "󰂄";
              format-time = "{H}:{M}";
              format-icons = [
                "󰁻"
                "󰁽"
                "󰁿"
                "󰂀"
                "󰁹"
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
            * {
              font-family: "JetBrainsMono NF";
              font-size: 16px;
            }

            window#waybar {
              border-radius: 8px;
              color: #cdd6f4;
              border: 2px solid #45475a;
              background: #181825;
              opacity: 0.85;
            }

            tooltip {
              background: #181825;
              border: 1.5px solid #45475a;
              opacity: 0.85;
            }

            tooltip label {
              color: #cdd6f4;
            }

            #workspaces button {
              padding: 0;
              background: transparent;
              transition: all 0.3s ease;
              font-size: 14px;
            }

            #workspaces button:hover {
              color: #cba6f7;
            }

            #workspaces button.active {
              color: #cba6f7;
            }

            #workspaces button.urgent {
              color: #f38ba8;
            }

            #custom-notifications {
              margin-bottom: 15px;
            }

            #image {
              margin-top: 15px;
              margin-bottom: 10px;
            }

            #custom-sep {
              color: #45475a;
            }
          '';
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.waybar.enable = false;
    };
  };
}
