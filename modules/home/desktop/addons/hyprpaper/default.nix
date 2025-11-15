{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.desktop.addons.hyprpaper = {
    enable = mkEnableOption "hyprpaper wallpaper manager";
  };

  config = mkIf cli.cava.enable {
    home-manager.users.${user.name} = {
      home.file = {
        "Pictures/Wallpapers" = {
          source = ../../../../../wallpapers;
          recursive = true;
        };
      };

      services.hyprpaper = {
        enable = true;

        settings =
          let
            wallpaperName = "a_cartoon_of_a_woman_in_a_pool.jpg";
          in
          {
            preload = [ "~/Pictures/Wallpapers/${wallpaperName}" ];
            wallpaper = [ ",~/Pictures/Wallpapers/${wallpaperName}" ];
          };
      };

      # wayland.windowManager.hyprland.settings.exec-once = [ "${pkgs.hyprpaper}/bin/hyprpaper" ]; # TODO: use a systemd service
    };
  };
}
