{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.yazi = {
    enable = mkEnableOption "Yazi file explorer";
  };

  config = mkIf cli.yazi.enable {
    home-manager.users.${user.name} = {
      programs.yazi = {
        enable = true;

        settings = { };

        plugins = {
          lazygit = pkgs.yaziPlugins.lazygit;
          full-border = pkgs.yaziPlugins.full-border;
          git = pkgs.yaziPlugins.git;
          smart-enter = pkgs.yaziPlugins.smart-enter;
        };
      };
    };
  };
}
