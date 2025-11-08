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
            margin-right = 8;
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
              "network"
              # "custom/sep"
              # "cpu"
              # "custom/sep"
              # "memory"
              # "custom/sep"
              # "disk"
              "custom/sep"
              "clock"
            ];

            network = {
              # interface = var.hyprland.waybar.network;
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
              tooltip-format = "{ifname} via {gwaddr} 󰊗";
              tooltip-format-wifi = "{essid} ({signalStrength}%) ";
              tooltip-format-ethernet = "{ifname} ";
              tooltip-format-disconnected = "Disconnected 󰤭";
              max-length = 50;
            };

            "image#nixos" = {
              path = "${pkgs.nixos-icons}/share/icons/hicolor/24x24/apps/nix-snowflake-white.png";
              size = 24;
              on-click = "swaync-client -t -sw";
            };

            pulseaudio = {
              format = "   {volume}";
              format-muted = "";
              on-click = "pavucontrol";
            };

            "pulseaudio/slider" = {
              "min" = 0;
              "max" = 100;
              "orientation" = "horizontal";
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
              format-alt = "{:%d/%m/%Y}";
              tooltip = false;
            };
            cpu = {
              format = "CPU: {usage}%";
              tooltip = false;
            };
            memory = {
              format = "Mem: {used}GiB";
            };
            disk = {
              interval = 60;
              path = "/";
              format = "Disk: {free}";
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
          let
            # colors = config.lib.stylix.colors;
            # hex = base: "#${base}";
          in
          ''
            @define-color bg    #1a1b26;
            @define-color fg    #a9b1d6;
            @define-color blk   #32344a;
            @define-color red   #f7768e;
            @define-color grn   #9ece6a;
            @define-color ylw   #e0af68;
            @define-color blu   #7aa2f7;
            @define-color mag   #ad8ee6;
            @define-color cyn   #0db9d7;
            @define-color brblk #444b6a;
            @define-color white #ffffff;

            * {
              font-size: 14px;
            }

            window#waybar {
              background-color: @bg;
              color: @fg;
              border-radius: 8px;
            }

            #workspaces button {
                padding: 0 6px;
                color: @cyn;
                background: transparent;
                border-bottom: 3px solid @bg;
            }
            #workspaces button.active {
                color: @cyn;
                border-bottom: 3px solid @mag;
            }
            #workspaces button.empty {
                color: @white;
            }
            #workspaces button.empty.active {
                color: @cyn;
                border-bottom: 3px solid @mag;
            }

            #workspaces button.urgent {
                background-color: @red;
            }

            #clock,
            #custom-sep,
            #battery,
            #cpu,
            #memory,
            #disk,
            #network,
            #tray {
                padding: 0 8px;
                color: @white;
            }

            #custom-sep {
                color: @brblk;
            }

            #clock {
                color: @cyn;
            }

            #battery {
                color: @mag;
            }

            #disk {
                color: @ylw;
            }

            #memory {
                color: @mag;
            }

            #cpu {
                color: @grn;
            }

            #network {
                color: @blu;
            }

            #network.disconnected {
                background-color: @red;
            }
          '';
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.waybar.enable = false;
    };
  };
}
