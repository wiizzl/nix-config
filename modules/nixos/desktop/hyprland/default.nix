{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop system;
in
{
  options.my.desktop.hyprland = {
    enable = mkEnableOption "Hyprland desktop environment";
  };

  config = mkIf desktop.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment = {
      sessionVariables = {
        # TODO: Move to home-manager?
        NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      systemPackages =
        with pkgs;
        [
          playerctl
          wl-clipboard
          gnome-icon-theme
          adwaita-icon-theme
        ]
        ++ (if system.audio.pipewire.enable || system.networkmanager.enable then [ pavucontrol ] else [ ])
        ++ (if system.networking.networkmanager.enable then [ networkmanagerapplet ] else [ ]);
    };
  };
}
