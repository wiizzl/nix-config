{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.nix.extra-substituters = {
    enable = mkEnableOption "extra-substituters for NixOS";
  };

  config = mkIf system.nix.extra-substituters.enable {
    nix.settings = {
      extra-substituters = [
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];
      extra-trusted-substituters = [
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };
}
