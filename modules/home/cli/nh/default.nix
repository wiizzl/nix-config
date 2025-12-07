{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.nh = {
    enable = mkEnableOption "Yet Another Nix CLI Helper (nh)";
    clean.enable = mkEnableOption "automatic cleaning of old generations";
  };

  config = mkIf cli.nh.enable {
    home-manager.users.${user.name} = {
      programs.nh = {
        enable = true;
        clean = mkIf cli.nh.clean.enable {
          enable = true;
          extraArgs = "--keep-since 4d --keep 3";
        };
        flake = "/home/${user.name}/nix-config";
      };
    };
  };
}
