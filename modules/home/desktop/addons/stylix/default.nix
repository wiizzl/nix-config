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
  imports = [ inputs.stylix.nixosModules.stylix ];

  config = mkIf desktop.addons.stylix.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.stylix.homeModules.stylix ];
    };
  };
}
