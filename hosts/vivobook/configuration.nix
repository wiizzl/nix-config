{ pkgs, lib, ... }:

let
  inherit (lib.extraMkOptions) enabled disabled;
in
{
  imports = [
    ../../modules/nixos/import.nix
    ../../modules/shared/import.nix
    ../../modules/home/import.nix
  ];

  config = {
    system.stateVersion = "25.05";

    my = {
      user = {
        enable = true;
        name = "pier";
        homeDir = "/home/pier";
        home-manager = enabled;
        wsl = enabled;

        shell = {
          package = pkgs.fish;
          starship = enabled;
        };
      };

      cli = {
        direnv = enabled;
        yazi = enabled;
        git = {
          enable = true;
          name = "wiizzl";
          email = "git@houlliere.com";
        };
      };

      system = {
        ld = enabled;
        shell.fish = enabled;
        timezone = "Europe/Paris";
        utils = {
          enable = true;
          dev = true;
          fun = true;
        };
        virtualisation = {
          docker = enabled;
        };
      };
    };
  };
}
