{ pkgs, lib, ... }:

let
  inherit (lib.extraMkOptions) enabled disabled;
in
{
  imports = [
    ./hardware-configuration.nix

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

        shell = {
          package = pkgs.fish;
          starship = enabled;
        };
      };

      apps = {
        dbeaver = enabled;
        gimp = enabled;
        obs = enabled;
        spotify = enabled;
        media = {
          qimgv = enabled;
          vlc = enabled;
        };
        suite.onlyoffice = enabled;
        file-manager.thunar = enabled;
        terminal.wezterm = enabled;
        editor = {
          zed = enabled;
          vscode = enabled;
        };
        social = {
          nixcord = {
            vesktop = enabled;
          };
          thunderbird = enabled;
        };
        browser = {
          zen = enabled;
        };
        jetbrains = {
          rider = enabled;
          android-studio = enabled;
        };
      };

      cli = {
        helix = enabled;
        nh = enabled;
        cava = enabled;
        direnv = enabled;
        microfetch = enabled;
        just = enabled;
        btop = enabled;
        yazi = enabled;
        git = {
          enable = true;
          name = "wiizzl";
          email = "git@houlliere.com";
        };
      };

      desktop = {
        hyprland = enabled;

        addons = {
          ly = enabled;
          hyprpicker = enabled;
          swaync = enabled;
          hyprshot = enabled;
          hyprpaper = enabled;
          rofi = enabled;
          waybar = enabled;
          stylix = {
            enable = true;
            autoEnable = true;
            polarity = "dark";

            # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
            base16Scheme = {
              base00 = "1e1e2e";
              base01 = "181825";
              base02 = "313244";
              base03 = "45475a";
              base04 = "585b70";
              base05 = "cdd6f4";
              base06 = "f5e0dc";
              base07 = "b4befe";
              base08 = "f38ba8";
              base09 = "fab387";
              base0A = "f9e2af";
              base0B = "a6e3a1";
              base0C = "94e2d5";
              base0D = "cba6f7";
              base0E = "89b4fa";
              base0F = "f2cdcd";
            };

            cursor = {
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Ice";
              size = 32;
            };

            fonts = {
              monospace = {
                package = pkgs.nerd-fonts.meslo-lg;
                name = "Meslo LGM Nerd Font";
              };
              sansSerif = {
                package = pkgs.montserrat;
                name = "Montserrat";
              };
              serif = {
                package = pkgs.dm-sans;
                name = "DM Sans";
              };
              emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
              };
              sizes = {
                applications = 11;
                desktop = 11;
                popups = 11;
                terminal = 13;
              };
            };
          };
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
        fonts = {
          enable = true;
          default = true;
        };
        shell.fish = enabled;
        timezone = "Europe/Paris";
        utils = {
          enable = true;
          dev = true;
          fun = true;
        };
        audio.pipewire = enabled;
        boot = {
          systemd.enable = true;
          kernel = pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.
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
        networking = {
          firewall = disabled;
          hostname = "nixos";
          networkmanager = enabled;
        };
        nix = {
          flakes.extra-options = ''
            warn-dirty = false
          '';
          garbage-collector = {
            enable = true;
            dates = "weekly";
            days = 7;
            auto-optimise-store = true;
          };
        };
        services = {
          bluetooth = {
            enable = true;
            blueman = true;
          };
          keyring = {
            enable = true;
            seahorse = true;
          };
          openssh = enabled;
        };
        video.amd = enabled;
        virtualisation = {
          podman = {
            enable = true;
            docker-compat = true;
            podman-desktop = true;
          };
          libvirtd = {
            enable = true;
            virt-manager = true;
          };
        };
      };
    };
  };
}
