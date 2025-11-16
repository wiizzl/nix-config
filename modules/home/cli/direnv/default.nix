{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.direnv = {
    enable = mkEnableOption "direnv";
    nix-direnv.enable = mkEnableOption "nix-direnv";
  };

  config = mkIf cli.direnv.enable {
    home-manager.users.${user.name} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = cli.direnv.nix-direnv.enable;
      };
    };
  };
}
