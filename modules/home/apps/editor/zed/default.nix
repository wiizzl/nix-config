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
    home-manager.users.${user.name} =
      { ... }:
      {
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

          # userSettings = {
          #   agent = {
          #     inline_assistant_model = {
          #       provider = "copilot_chat";
          #       model = "gpt-4.1";
          #     };
          #     default_profile = "ask";
          #     default_model = {
          #       provider = "copilot_chat";
          #       model = "gpt-4o";
          #     };
          #     dock = "left";
          #   };
          #   project_panel = {
          #     dock = "left";
          #   };
          #   diagnostics = {
          #     button = false;
          #     include_warnings = true;
          #     inline = {
          #       enabled = true;
          #       update_debounce_ms = 150;
          #       padding = 4;
          #       min_column = 0;
          #       max_severity = null;
          #     };
          #   };
          #   indent_guides = {
          #     enabled = true;
          #     line_width = 1;
          #     active_line_width = 2;
          #     coloring = "indent_aware";
          #   };
          # };
        };
      };
  };
}
