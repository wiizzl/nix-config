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
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [
        "https://hyprland.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
