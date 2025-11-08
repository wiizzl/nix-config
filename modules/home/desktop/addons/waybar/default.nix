{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.waybar = {
    enable = mkEnableOption "Waybar status bar";
  };

  config = mkIf desktop.addons.waybar.enable {
    home-manager.users.${user.name} =
      # mkIf desktop.addons.stylix.enable {
      #   stylix.targets.waybar.enable = false;
      # }
      # // {
      {
        # wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ]; # TODO: use a systemd service

        programs.waybar = {
          enable = true;

          settings = {
            mainBar = {
              layer = "top";
              position = "top";
              output = [ "DP-2" ];

              margin-top = 8;
              margin-right = 8;
              margin-left = 8;

              spacing = 10;

              modules-left = [
                "image#nixos"
                "hyprland/workspaces"
                "hyprland/window"
              ];
              modules-center = [
                "clock"
              ];
              modules-right = [
                "pulseaudio/slider"
                "pulseaudio"
                "battery"
                "network"
                "bluetooth"
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
              };

              "hyprland/window" = {
                format = "{initialTitle}";
                separate-outputs = true;
              };

              bluetooth = {
                format = " {status}";
                on-click = "blueman-manager";
                format-connected = " {num_connections}";
                format-disabled = "󰂲";
                tooltip-format = "{controller_alias}\t{controller_address}";
                tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
                tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
              };

              battery = {
                format = "{capacity}% {icon}";
                format-icons = [
                  ""
                  ""
                  ""
                  ""
                  ""
                ];
              };

              clock = {
                interval = 1;
                format = "{:%H:%M:%S}";
                format-alt = "{:%a, %d. %b  %H:%M}";
                tooltip-format = "<tt>{calendar}</tt>";
              };
            };
          };

          style =
            let
              # colors = config.lib.stylix.colors;
              # hex = base: "#${base}";
            in
            ''
              window#waybar {
                background: rgba(43, 48, 59, 0.5);

                border-radius: 8px;
                color: white;
              }

              tooltip {
                background: rgba(43, 48, 59, 0.5);
                border: 1px solid rgba(100, 114, 125, 0.5);
                border-radius: 8px;
              }

              tooltip label {
                color: white;
              }

              #workspaces button {
                padding: 0 5px;
                background: transparent;
                color: white;
                border-bottom: 3px solid transparent;
              }

              #workspaces button.focused {
                background: #64727D;
                border-bottom: 3px solid white;
              }

              #mode, #clock, #battery {
                padding: 0 10px;
              }

              #mode {
                background: #64727D;
                border-bottom: 3px solid white;
              }

              #clock {
                background-color: #64727D;
              }

              #battery {
                background-color: #ffffff;
                color: black;
              }

              #battery.charging {
                color: white;
                background-color: #26A65B;
              }

              #battery.warning:not(.charging) {
                background: #f53c3c;
                color: white;
              }

              #pulseaudio-slider {
                padding: 0;
                margin: 0;
              }

              #pulseaudio-slider slider {
                min-height: 0px;
                min-width: 0px;
                opacity: 0;
                background-image: none;
                border: none;
                box-shadow: none;
              }

              #pulseaudio-slider trough {
                min-height: 10px;
                min-width: 80px;
                border-radius: 5px;
                background: black;
              }

              #pulseaudio-slider highlight {
                min-width: 10px;
                border-radius: 5px;
                background: green;
              }
            '';
        };
      };
  };
}
