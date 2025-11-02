{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user system;
in
{
  options.my.cli.nh = {
    enable = mkEnableOption "Yet another Nix CLI helper (nh)";
  };

  config = mkIf cli.nh.enable {
    programs.nh = {
      enable = true;

      clean = {
        enable = !system.nix.garbage-collector.enable;
        extraArgs = "--keep-since ${toString system.nix.garbage-collector.days}d --keep 3";
      };

      flake = "${user.homeDir}/nix-config"; # sets NH_OS_FLAKE variable for you
    };
  };
}
