{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) user;
in
{
  options.my.user.shell = {
    package = mkOpt types.package pkgs.bash "Shell package";
  };

  config = mkIf user.enable {
    users.users.${user.name}.shell = user.shell.package;
  };
}
