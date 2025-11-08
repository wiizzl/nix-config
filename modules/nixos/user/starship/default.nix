{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) user;
in
{
  config = mkIf user.shell.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}
