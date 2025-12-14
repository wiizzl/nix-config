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
        name = "pier";
        shell = {
          package = pkgs.fish;
          starship = enabled;
        };
      };

      cli = {
        helix = enabled;
        microfetch = enabled;
        btop = enabled;
        yazi = enabled;
        git = {
          enable = true;
          name = "wiizzl";
          email = "git@houlliere.com";
          gh = enabled;
          lazygit = enabled;
        };
        direnv = {
          enable = true;
          nix-direnv = enabled;
        };
        nh = {
          enable = true;
          clean = enabled;
        };
      };

      services = {
        tailscale = enabled;
      };

      system = {
        allow = {
          unfree = enabled;
          broken = enabled;
        };
        shell.fish = enabled;
        timezone = "Europe/Paris";
        utils = {
          enable = true;
          dev = enabled;
          fun = enabled;
        };
        boot = {
          enable = true;
          systemd = enabled;
          kernel = pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.
        };
        docs = {
          enable = true;
          man = enabled;
        };
        locale = {
          keymap = "fr";
          default-locale = "en_US.UTF-8";
          extra-locale = "fr_FR.UTF-8";
        };
        networking = {
          firewall = enabled;
          hostname = "nixos";
          networkmanager = enabled;
        };
        nix = {
          ld = enabled;
          optimisation = enabled;
          flakes.extra-options = ''
            warn-dirty = false
          '';
        };
        services = {
          keyring = enabled;
          openssh = enabled;
        };
        virtualisation = {
          docker = {
            enable = true;
            lazydocker = enabled;
            distrobox = enabled;
          };
          libvirtd = enabled;
        };
      };
    };
  };
}
