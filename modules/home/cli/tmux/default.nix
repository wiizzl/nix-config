{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) cli user desktop;
in
{
  options.my.cli.tmux = {
    enable = mkEnableOption "Terminal multiplexer (tmux)";
  };

  config = mkIf cli.tmux.enable {
    home-manager.users.${user.name} = {
      programs.tmux = {
        enable = true;

        mouse = true;
        clock24 = true;
        shortcut = "a";
        baseIndex = 1;
        keyMode = "vi";
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.tmux.enable = false;
    };
  };
}
