{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.my) desktop user;
in
{
  config = mkIf desktop.addons.app-runner.walker.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.walker.homeManagerModules.default ];

      # programs.walker = {
      #   enable = true;
      #   runAsService = true;
      # };
      services.walker = {
        enable = true;
      };
    };
  };
}
