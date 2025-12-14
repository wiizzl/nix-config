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

          profiles.default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
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
              # biomejs.biome
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
              github.copilot-chat
              github.vscode-github-actions
              github.vscode-pull-request-github
              icrawl.discord-vscode
              tamasfe.even-better-toml
              redhat.vscode-yaml
              redhat.java
              bmewburn.vscode-intelephense-client
              junstyle.php-cs-fixer
              ms-vscode.remote-explorer
              ms-vscode-remote.remote-containers
              ms-vscode-remote.remote-ssh
              ms-vscode-remote.remote-ssh-edit
              ms-azuretools.vscode-containers
              formulahendry.auto-close-tag
              formulahendry.auto-rename-tag
              oven.bun-vscode
              # ms-dotnettools.csdevkit
              # ms-dotnettools.vscode-dotnet-runtime
              # ms-dotnettools.dotnet-maui
              # ms-dotnettools.csharp
            ];
          };
        };
      }
      // optionalAttrs desktop.addons.stylix.enable {
        stylix.targets.vscode.enable = false;
      };
  };
}
