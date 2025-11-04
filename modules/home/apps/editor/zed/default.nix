{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.my) apps desktop user;
in
{
  config = mkIf apps.editor.zed.enable {
    home-manager.users.${user.name} = {
      stylix = mkIf desktop.addons.stylix.enable {
        targets.zed.enable = false;
      };

      # xdg.configFile."zed" = {
      #   source = config.lib.file.mkOutOfStoreSymlink "./config";
      #   recursive = true;
      # };

      programs.zed-editor = {
        enable = true;

        extraPackages = with pkgs; [
          nixd
        ];

        extensions = [
          "html"
          "astro"
          "nix"
          "toml"
          "php"
          "dockerfile"
          "sql"
          "vue"
          "xml"
          "java"
          "prisma"
          "csharp"
          "biome"
          "catppuccin"
          "catppuccin-icons"
        ];
      };
    };
  };
}
