{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) cli user;
in
{
  options.my.cli.nh = {
    enable = mkEnableOption "Yet another Nix CLI helper (nh)";
    clean = {
      enable = mkEnableOption "automatic cleaning of old generations";
      days = mkOpt types.int 7 "Number of days after which to delete old generations";
    };
  };

  config = mkIf cli.nh.enable {
    programs.nh = {
      enable = true;

      clean = {
        enable = cli.nh.clean.enable;
        extraArgs = "--keep-since ${toString cli.nh.clean.days}d --keep 3";
      };

      flake = "${user.homeDir}/nix-config"; # sets NH_OS_FLAKE variable for you
    };
  };
}
