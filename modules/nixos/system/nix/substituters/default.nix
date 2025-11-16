{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.nix.substituters = {
    enable = mkEnableOption "substituters for NixOS";
  };

  config = mkIf system.nix.substituters.enable {
    nix.settings = {
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
    };
  };
}
