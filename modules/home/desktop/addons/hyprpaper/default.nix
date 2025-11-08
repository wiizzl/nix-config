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
      services.hyprpaper = {
        enable = true;

        settings = {
          ipc = "off";
          splash = false;

          preload = [ "~/nix-config/wallpapers/a_cartoon_of_a_woman_in_a_pool.jpg" ];
          wallpaper = [ ", ~/nix-config/wallpapers/a_cartoon_of_a_woman_in_a_pool.jpg" ];
        };
      };

      # wayland.windowManager.hyprland.settings.exec-once = [ "${pkgs.hyprpaper}/bin/hyprpaper" ]; # TODO: use a systemd service
    };
  };
}
