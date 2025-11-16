{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.vicinae = {
    enable = mkEnableOption "Vicinae application launcher";
  };

  config = mkIf desktop.addons.vicinae.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.vicinae.homeManagerModules.default ];

      services.vicinae = {
        enable = true;
        package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;

        autoStart = true;
        useLayerShell = true;

        settings = {
          font = {
            normal = "JetBrainsMono NF";
            size = 12;
          };

          theme.name = "catppuccin-mocha";

          window = {
            csd = true;
            opacity = 0.95;
            rounding = 8;
          };

          faviconService = "twenty";
          popToRootOnClose = true;
          rootSearch.searchFiles = false;
        };

        # TODO: Declarativily install extensions
        extensions = [
          # (inputs.vicinae.mkVicinaeExtension.${pkgs.system} {
          #   inherit pkgs;
          #   name = "extension-name";
          #   src = pkgs.fetchFromGitHub {
          #     # You can also specify different sources other than github
          #     owner = "repo-owner";
          #     repo = "repo-name";
          #     rev = "v1.0"; # If the extension has no releases use the latest commit hash
          #     # You can get the sha256 by rebuilding once and then copying the output hash from the error message
          #     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          #   }; # If the extension is in a subdirectory you can add ` + "/subdir"` between the brace and the semicolon here
          # })
          # (inputs.vicinae.mkRayCastExtension {
          #   name = "gif-search";
          #   sha256 = "sha256-G7il8T1L+P/2mXWJsb68n4BCbVKcrrtK8GnBNxzt73Q=";
          #   rev = "4d417c2dfd86a5b2bea202d4a7b48d8eb3dbaeb1";
          # })
        ];
      };
    };
  };
}
