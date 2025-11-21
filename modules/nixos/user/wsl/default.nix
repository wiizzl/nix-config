{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) user;
in
{
  options.my.user.wsl = {
    enable = mkEnableOption "WSL support";
  };

  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  config = mkIf user.wsl.enable {
    wsl = {
      enable = true;
      defaultUser = user.name;
      startMenuLaunchers = true;
      useWindowsDriver = true;
    };
  };
}
