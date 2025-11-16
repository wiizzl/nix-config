{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.helix = {
    enable = mkEnableOption "Helix editor";
  };

  config = mkIf cli.helix.enable {
    home-manager.users.${user.name} = {
      programs.helix = {
        enable = true;

        settings = {
          editor = {
            line-number = "relative";
            lsp.display-messages = true;
          };
        };
      };
    };
  };
}
