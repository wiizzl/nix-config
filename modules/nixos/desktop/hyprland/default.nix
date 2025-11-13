{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionals;
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

      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
        ++ optionals (system.audio.pipewire.enable || system.audio.pavucontrol.enable) [ pavucontrol ]
        ++ optionals (system.networking.networkmanager.enable) [ networkmanagerapplet ];
    };
  };
}
