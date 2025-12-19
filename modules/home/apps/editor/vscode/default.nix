{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) apps desktop user;
in
{
  options.my.apps.editor.vscode = {
    enable = mkEnableOption "Visual Studio Code editor";
  };

  config = mkIf apps.editor.vscode.enable {
    home-manager.users.${user.name} =
      { config, ... }:
      {
        xdg.configFile."Code/User/settings.json" = {
          source = config.lib.file.mkOutOfStoreSymlink "${user.homeDir}/nix-config/modules/home/apps/editor/vscode/config/settings.json";
        };

        programs.vscode = {
          enable = true;
          mutableExtensionsDir = false;

          profiles.default = {
            extensions =
              with pkgs.open-vsx;
              [
                dsznajder.es7-react-js-snippets
                wayou.vscode-todo-highlight
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
                ziglang.vscode-zig
                rust-lang.rust-analyzer
                vue.volar
                unifiedjs.vscode-mdx
                esbenp.prettier-vscode
                bradlc.vscode-tailwindcss
                ms-python.python
                ms-python.debugpy
                ms-python.vscode-python-envs
                charliermarsh.ruff
                meganrogge.template-string-converter
                github.vscode-github-actions
                icrawl.discord-vscode
                tamasfe.even-better-toml
                redhat.vscode-yaml
                redhat.java
                bmewburn.vscode-intelephense-client
                junstyle.php-cs-fixer
                formulahendry.auto-close-tag
                formulahendry.auto-rename-tag
                oven.bun-vscode
                # biomejs.biome
              ]
              ++ (with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
                golang.go
                github.copilot-chat
                ms-vsliveshare.vsliveshare
                quicktype.quicktype
                ms-vscode.remote-explorer
                ms-vscode-remote.remote-containers
                ms-vscode-remote.remote-ssh
                ms-vscode-remote.remote-ssh-edit
                ms-azuretools.vscode-containers
              ]);
          };
        };
      }
      // optionalAttrs desktop.addons.stylix.enable {
        stylix.targets.vscode.enable = false;
      };
  };
}
