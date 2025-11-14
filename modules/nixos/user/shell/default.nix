{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) user;
in
{
  options.my.user.shell = {
    package = mkOpt types.package pkgs.bash "Shell package";
  };

  config = {
    users.users.${user.name}.shell = user.shell.package;
  };
}
