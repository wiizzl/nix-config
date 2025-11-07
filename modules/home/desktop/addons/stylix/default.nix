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
  config = mkIf desktop.addons.stylix.enable {
    home-manager.users.${user.name} = {
      # imports = [ inputs.stylix.homeModules.stylix ];
    };
  };
}
