{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.app-runner.walker = {
    enable = mkEnableOption "Walker app runner";
  };

  config = mkIf desktop.addons.app-runner.walker.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.walker.homeManagerModules.default ];

      programs.walker = {
        enable = true;
        runAsService = true;
      };
    };
  };
}
