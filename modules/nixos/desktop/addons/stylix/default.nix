{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  inherit (lib.extraMkOptions) mkOpt mkOpt' mkOpt_;

  inherit (config.my) desktop;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  options.my.desktop.addons.stylix = {
    enable = mkEnableOption "Stylix theming framework";
    autoEnable = mkOpt types.bool false "Auto-enable Stylix on supported applications";
    polarity = mkOpt types.str "dark" "Algorithm's preferred polarity (dark or light)";
    base16Scheme = mkOption {
      description = "The base16 color scheme to use";
      type = types.submodule {
        options = {
          base00 = mkOpt' types.str;
          base01 = mkOpt' types.str;
          base02 = mkOpt' types.str;
          base03 = mkOpt' types.str;
          base04 = mkOpt' types.str;
          base05 = mkOpt' types.str;
          base06 = mkOpt' types.str;
          base07 = mkOpt' types.str;
          base08 = mkOpt' types.str;
          base09 = mkOpt' types.str;
          base0A = mkOpt' types.str;
          base0B = mkOpt' types.str;
          base0C = mkOpt' types.str;
          base0D = mkOpt' types.str;
          base0E = mkOpt' types.str;
          base0F = mkOpt' types.str;
        };
      };
    };
    cursor = mkOption {
      description = "Cursor theme configuration";
      type = types.submodule {
        options = {
          package = mkOpt_ types.package "The Nix package providing the cursor theme";
          name = mkOpt_ types.str "The name of the cursor theme";
          size = mkOpt types.int 24 "The size of the cursor theme";
        };
      };
    };
    fonts = mkOption {
      description = "Font configuration for Stylix";
      type = types.submodule {
        options = {
          monospace = mkOption {
            description = "Monospace font configuration";
            type = types.submodule {
              options = {
                package = mkOpt_ types.package "The Nix package providing the monospace font";
                name = mkOpt_ types.str "The name of the monospace font";
              };
            };
          };
          sansSerif = mkOption {
            description = "Sans-serif font configuration";
            type = types.submodule {
              options = {
                package = mkOpt_ types.package "The Nix package providing the sans-serif font";
                name = mkOpt_ types.str "The name of the sans-serif font";
              };
            };
          };
          serif = mkOption {
            description = "Serif font configuration";
            type = types.submodule {
              options = {
                package = mkOpt_ types.package "The Nix package providing the serif font";
                name = mkOpt_ types.str "The name of the serif font";
              };
            };
          };
          emoji = mkOption {
            description = "Emoji font configuration";
            type = types.submodule {
              options = {
                package = mkOpt_ types.package "The Nix package providing the emoji font";
                name = mkOpt_ types.str "The name of the emoji font";
              };
            };
          };
          sizes = mkOption {
            description = "Font sizes configuration";
            type = types.submodule {
              options = {
                applications = mkOpt_ types.int "Font size for applications";
                desktop = mkOpt_ types.int "Font size for desktop elements";
                popups = mkOpt_ types.int "Font size for popups";
                terminal = mkOpt_ types.int "Font size for terminal";
              };
            };
          };
        };
      };
    };
  };

  config = mkIf desktop.addons.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = desktop.addons.stylix.autoEnable;
      polarity = desktop.addons.stylix.polarity;
      base16Scheme = desktop.addons.stylix.base16Scheme;
      cursor = desktop.addons.stylix.cursor;
      fonts = desktop.addons.stylix.fonts;
    };
  };
}
