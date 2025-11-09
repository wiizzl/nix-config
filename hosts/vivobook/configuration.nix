{ pkgs, lib, ... }:

let
  inherit (lib.extraMkOptions) enabled;
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
        just = enabled;
        btop = enabled;
        microfetch = enabled;
        helix = enabled;
        git = {
          enable = true;
          name = "wiizzl";
          email = "git@houlliere.com";
        };
      };

      system = {
        shell.fish = enabled;
        timezone = "Europe/Paris";
        utils = {
          enable = true;
          dev = true;
          fun = true;
        };
        docs = {
          enable = true;
          man = true;
        };
        locale = {
          keymap = "fr";
          default-locale = "en_US.UTF-8";
          extra-locale = "fr_FR.UTF-8";
        };
        nix = {
          ld = enabled;
          extra-substituters = enabled;
          flakes.extra-options = ''
            warn-dirty = false
          '';
        };
        networking = {
          firewall = enabled;
          hostname = "vivobook";
        };
        virtualisation = {
          docker = enabled;
        };
      };
    };
  };
}
