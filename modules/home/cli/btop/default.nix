{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) cli user;
in
{
  config = mkIf cli.btop.enable {
    home-manager.users.${user.name} = {
      programs.btop = {
        enable = true;

        settings = {
          theme_background = false;
          vim_keys = true;
        };
      };
    };
  };
}
