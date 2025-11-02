{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  inherit (config.my) cli;
in
{
  options.my.cli.git = {
    enable = mkEnableOption "Enable git";
    name = mkOption {
      type = types.str;
      description = "Git user name";
    };
    email = mkOption {
      type = types.str;
      description = "Git user email";
    };
  };

  config = mkIf cli.git.enable {
    environment.systemPackages = with pkgs; [
      git
      gh
    ];
  };
}
