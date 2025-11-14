{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) cli user;
in
{
  config = mkIf cli.tmux.enable {
    home-manager.users.${user.name} =
      { config, ... }:
      {
        xdg.configFile."tmux/tmux.conf" = {
          source = config.lib.file.mkOutOfStoreSymlink "${user.homeDir}/nix-config/modules/home/cli/tmux/config/tmux.conf";
        };

        programs.tmux = {
          enable = true;
        };
      };
  };
}
