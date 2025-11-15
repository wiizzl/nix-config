{ pkgs, lib, ... }:

let
  inherit (lib.extraMkOptions) enabled;
in
{
  imports = [
    ./hardware-configuration.nix

    ../../overlays/nix-vscode-extensions

    ../../modules/nixos/import.nix
    ../../modules/shared/import.nix
    ../../modules/home/import.nix
  ];

  config = {
    system.stateVersion = "25.05";

    my = {
      user = {
        name = "pier";
        home-manager.userDirs = enabled;
        shell = {
          package = pkgs.fish;
          starship = enabled;
        };
      };

      apps = {
        dbeaver = enabled;
        obs = enabled;
        spotify = enabled;
        media = {
          qimgv = enabled;
          vlc = enabled;
          localsend = enabled;
          pinta = enabled;
        };
        suite.onlyoffice = enabled;
        terminal.foot = enabled;
        editor = {
          zed = enabled;
          vscode = enabled;
        };
        social = {
          nixcord = {
            enable = true;
            vesktop = enabled;
          };
          thunderbird = enabled;
        };
        browser = {
          zen = enabled;
        };
      };

      cli = {
        impala = enabled;
        tmux = enabled;
        helix = enabled;
        cava = enabled;
        direnv = enabled;
        microfetch = enabled;
        btop = enabled;
        yazi = enabled;
        git = {
          enable = true;
          name = "wiizzl";
          email = "git@houlliere.com";
          lazygit = enabled;
        };
      };

      desktop = {
        hyprland = {
          enable = true;
          monitors = [
            "DP-2, 1920x1080@164.92, 0x0, 1"
            "HDMI-A-2, 1920x1200@59.95, auto-center-left, 1, transform, 1"
          ];
          defaultApps = {
            terminal = "foot";
            fileManager = "$terminal -e yazi";
            browser = "zen-beta";
            music = "spotify";
          };
        };

        addons = {
          rofi = enabled;
          vicinae = enabled;
          ly = enabled;
          hyprpicker = enabled;
          swaync = enabled;
          swayosd = enabled;
          hyprshot = enabled;
          hyprpaper = enabled;
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

            cursorEnable = true;
            cursor = {
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Ice";
              size = 32;
            };

            fontsEnable = true;
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
          dev = enabled;
          fun = enabled;
        };
        audio.pipewire = enabled;
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
          substituters = enabled;
          flakes.extra-options = ''
            warn-dirty = false
          '';
          garbage-collector = {
            enable = true;
            auto-optimise-store = enabled;
            dates = "weekly";
            days = 7;
          };
        };
        services = {
          bluetooth = {
            enable = true;
            blueman = enabled;
          };
          keyring = {
            enable = true;
            seahorse = enabled;
          };
          openssh = enabled;
        };
        video.amd = enabled;
        virtualisation = {
          docker = {
            enable = true;
            lazydocker = enabled;
          };
          libvirtd = {
            enable = true;
            virt-manager = enabled;
          };
        };
      };
    };
  };
}
