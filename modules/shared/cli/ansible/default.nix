{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli;
in
{
  options.my.cli.ansible = {
    enable = mkEnableOption "ansible";
  };

  config = mkIf cli.ansible.enable {
    environment.systemPackages = with pkgs; [
      ansible
    ];
  };
}
