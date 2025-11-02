{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.extraMkOptions) mkOpt_;

  inherit (config.my) cli;
in
{
  options.my.cli.git = {
    enable = mkEnableOption "git";
    name = mkOpt_ types.str "Git user name";
    email = mkOpt_ types.str "Git user email";
  };

  config = mkIf cli.git.enable {
    environment.systemPackages = with pkgs; [
      git
      gh
    ];
  };
}
