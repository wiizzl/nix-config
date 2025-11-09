{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf optionalAttrs;
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
      { config, ... }:
      {
        xdg.configFile."Code/User/settings.json" = {
          source = config.lib.file.mkOutOfStoreSymlink "${user.homeDir}/nix-config/modules/home/apps/editor/vscode/config/settings.json";
        };

        programs.vscode = {
          enable = true;

          profiles.default = {
            extensions = with pkgsWithOverlay.vscode-marketplace-release; [
              gruntfuggly.todo-tree
              astro-build.astro-vscode
              jnoortheen.nix-ide
              adpyke.codesnap
              naumovs.color-highlight
              catppuccin.catppuccin-vsc
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
              tamasfe.even-better-toml
              bmewburn.vscode-intelephense-client
              ms-vscode.remote-explorer
              ms-vscode-remote.remote-ssh
              ms-vscode-remote.remote-ssh-edit
              ms-azuretools.vscode-containers
              formulahendry.auto-close-tag
              formulahendry.auto-rename-tag
            ];
          };
        };
      }
      // optionalAttrs desktop.addons.stylix.enable {
        stylix.targets.vscode.enable = false;
      };
  };
}
