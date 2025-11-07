{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.my) apps desktop user;

  pkgsWithOverlay = import pkgs.path {
    system = pkgs.stdenv.hostPlatform.system;
    overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    config = pkgs.config;
  };
in
{
  config = mkIf apps.editor.vscode.enable {
    home-manager.users.${user.name} =
      mkIf desktop.addons.stylix.enable {
        stylix.targets.vscode.enable = false;
      }
      // {
        programs.vscode = {
          enable = true;

          profiles.default = {
            userSettings = {
              # Theme
              "workbench.iconTheme" = "flow-dim";
              "workbench.colorTheme" = "Catppuccin Mocha";
              "workbench.productIconTheme" = "material-product-icons";

              # Misc
              "workbench.startupEditor" = "none";
              "files.enableTrash" = true;
              "explorer.compactFolders" = false;
              "editor.linkedEditing" = true;
              "files.trimTrailingWhitespace" = true;

              # Formatter
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
              "prettier.printWidth" = 120;
              "prettier.documentSelectors" = [ "**/*.astro" ];
              "[astro]"."editor"."defaultFormatter" = "esbenp.prettier-vscode";
              "[prisma]"."editor"."defaultFormatter" = "Prisma.prisma";
              "[python]"."editor"."defaultFormatter" = "charliermarsh.ruff";
              "[nix]"."editor"."defaultFormatter" = "jnoortheen.nix-ide";

              # Font
              "editor.fontLigatures" = true;

              # Font size
              "editor.fontSize" = 16;
              "terminal.integrated.fontSize" = 15;

              # Tab size
              "editor.tabSize" = 2;

              # Files limitation
              "workbench.editor.limit.enabled" = true;
              "workbench.editor.limit.value" = 6;

              # Typescript
              "typescript.inlayHints.parameterNames.enabled" = "all";
              "typescript.updateImportsOnFileMove.enabled" = "always";

              # Files save
              "files.autoSave" = "onFocusChange";
              "editor.formatOnSave" = true;
              "editor.codeActionsOnSave" = {
                "source.fixAll" = "explicit";
                "source.organizeImports" = "explicit";
              };

              # Window UI
              "editor.semanticHighlighting.enabled" = true;
              "terminal.integrated.minimumContrastRatio" = 1;
              "window.titleBarStyle" = "native";
              "window.menuBarVisibility" = "toggle";
              "window.commandCenter" = false;
              "workbench.activityBar.location" = "hidden";
              "workbench.layoutControl.enabled" = false;
              "workbench.sideBar.location" = "right";
              "editor.accessibilitySupport" = "off";
              "editor.bracketPairColorization.enabled" = true;
              "editor.guides.bracketPairs" = true;

              # Git
              "git.autofetch" = true;
              "git.confirmSync" = false;
              "git.ignoreRebaseWarning" = true;
              "git.enableSmartCommit" = true;

              # Delete confirmation
              "explorer.confirmDelete" = false;
              "explorer.confirmDragAndDrop" = false;

              # Smooth animations
              "editor.cursorSmoothCaretAnimation" = "on";
              "editor.smoothScrolling" = true;
              "workbench.list.smoothScrolling" = true;
              "terminal.integrated.smoothScrolling" = true;
              "editor.cursorBlinking" = "expand";

              # Discord RPC
              "vscord.app.name" = "Visual Studio Code";
              "vscord.status.idle.enabled" = false;
            };

            extensions = with pkgsWithOverlay.vscode-marketplace-release; [
              gruntfuggly.todo-tree
              astro-build.astro-vscode
              jnoortheen.nix-ide
              adpyke.codesnap
              naumovs.color-highlight
              catppuccin.catppuccin-vsc
              pkief.material-product-icons
              thang-nm.flow-icons
              usernamehw.errorlens
              yoavbls.pretty-ts-errors
              dbaeumer.vscode-eslint
              prisma.prisma
              golang.go
              ziglang.vscode-zig
              rust-lang.rust-analyzer
              vue.volar
              ms-vsliveshare.vsliveshare
              unifiedjs.vscode-mdx
              quicktype.quicktype
              esbenp.prettier-vscode
              bradlc.vscode-tailwindcss
              ms-python.python
              ms-python.debugpy
              ms-python.vscode-python-envs
              charliermarsh.ruff
              meganrogge.template-string-converter
              github.copilot
              github.copilot-chat
              github.vscode-github-actions
              github.vscode-pull-request-github
              leonardssh.vscord
              bmewburn.vscode-intelephense-client
            ];
          };
        };
      };
  };
}
