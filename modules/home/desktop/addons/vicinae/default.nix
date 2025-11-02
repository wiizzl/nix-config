{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.vicinae = {
    enable = mkEnableOption "Vicinae app launcher";
  };

  config = mkIf desktop.addons.vicinae.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.vicinae.homeManagerModules.default ];

      services.vicinae = {
        enable = true;
        autoStart = true;
      };
    };
  };
}
