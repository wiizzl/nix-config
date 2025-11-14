{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) user;

  starship-config = import ../../../../nixos/user/shell/starship {
    inherit config lib;
  };
in
{
  config = mkIf user.shell.starship.enable {
    home-manager.users.${user.name} = starship-config;
  };
}
