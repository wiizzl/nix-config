{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  inherit (config.my) desktop;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  options.my.desktop.addons.stylix = {
    enable = mkEnableOption "Enable Stylix theming framework";
    autoEnable = mkOption {
      type = types.bool;
      default = false;
      description = "Auto-enable Stylix on supported applications";
    };
    polarity = mkOption {
      type = types.str;
      default = "dark";
      description = "Algorithm's preferred polarity (dark or light)";
    };
    base16Scheme = mkOption {
      default = { };
      description = "The base16 color scheme to use";
      type = types.submodule {
        options = {
          base00 = mkOption {
            type = types.str;
            description = "Default Background";
          };
          base01 = mkOption {
            type = types.str;
            description = "Lighter Background (Used for status bars, line number and folding marks)";
          };
          base02 = mkOption {
            type = types.str;
            description = "Selection Background";
          };
          base03 = mkOption {
            type = types.str;
            description = "Comments, Invisibles, Line Highlighting";
          };
          base04 = mkOption {
            type = types.str;
            description = "Dark Foreground (Used for status bars)";
          };
          base05 = mkOption {
            type = types.str;
            description = "Default Foreground, Caret, Delimiters, Operators";
          };
          base06 = mkOption {
            type = types.str;
            description = "Light Foreground (Not often used)";
          };
          base07 = mkOption {
            type = types.str;
            description = "Light Background (Not often used)";
          };
          base08 = mkOption {
            type = types.str;
            default = "f38ba8";
            description = "Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted";
          };
          base09 = mkOption {
            type = types.str;
            description = "Integers, Boolean, Constants, XML Attributes, Markup Link Url";
          };
          base0A = mkOption {
            type = types.str;
            description = "Classes, Markup Bold, Search Text Background";
          };
          base0B = mkOption {
            type = types.str;
            description = "Strings, Inherited Class, Markup Code, Diff Inserted";
          };
          base0C = mkOption {
            type = types.str;
            description = "Support, Regular Expressions, Escape Characters, Markup Quotes";
          };
          base0D = mkOption {
            type = types.str;
            description = "Functions, Methods, Attribute IDs, Headings, Accent color";
          };
          base0E = mkOption {
            type = types.str;
            description = "Keywords, Storage, Selector, Markup Italic, Diff Changed";
          };
          base0F = mkOption {
            type = types.str;
            description = "Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>";
          };
        };
      };
    };
    cursor = mkOption {
      default = { };
      description = "Cursor theme configuration";
      type = types.submodule {
        options = {
          package = mkOption {
            type = types.package;
            description = "The Nix package providing the cursor theme";
          };
          name = mkOption {
            type = types.str;
            description = "The name of the cursor theme";
          };
          size = mkOption {
            type = types.int;
            description = "The size of the cursor theme";
          };
        };
      };
    };
    fonts = mkOption {
      default = { };
      description = "Font configuration for Stylix";
      type = types.submodule {
        options = {
          monospace = mkOption {
            description = "Monospace font configuration";
            type = types.submodule {
              options = {
                package = mkOption {
                  type = types.package;
                  description = "The Nix package providing the monospace font";
                };
                name = mkOption {
                  type = types.str;
                  description = "The name of the monospace font";
                };
              };
            };
          };
          sansSerif = mkOption {
            description = "Sans-serif font configuration";
            type = types.submodule {
              options = {
                package = mkOption {
                  type = types.package;
                  description = "The Nix package providing the sans-serif font";
                };
                name = mkOption {
                  type = types.str;
                  description = "The name of the sans-serif font";
                };
              };
            };
          };
          serif = mkOption {
            description = "Serif font configuration";
            type = types.submodule {
              options = {
                package = mkOption {
                  type = types.package;
                  description = "The Nix package providing the serif font";
                };
                name = mkOption {
                  type = types.str;
                  description = "The name of the serif font";
                };
              };
            };
          };
          emoji = mkOption {
            description = "Emoji font configuration";
            type = types.submodule {
              options = {
                package = mkOption {
                  type = types.package;
                  description = "The Nix package providing the emoji font";
                };
                name = mkOption {
                  type = types.str;
                  description = "The name of the emoji font";
                };
              };
            };
          };
          sizes = mkOption {
            description = "Font sizes configuration";
            type = types.submodule {
              options = {
                applications = mkOption {
                  type = types.int;
                  description = "Font size for applications";
                };
                desktop = mkOption {
                  type = types.int;
                  description = "Font size for desktop elements";
                };
                popups = mkOption {
                  type = types.int;
                  description = "Font size for popups";
                };
                terminal = mkOption {
                  type = types.int;
                  description = "Font size for terminal";
                };
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
