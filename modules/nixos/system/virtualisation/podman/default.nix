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
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.podman = {
    enable = mkEnableOption "Enable Podman engine";
    docker-compat = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Docker compatibility mode";
    };
    podman-desktop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Podman Desktop GUI";
    };
  };

  config = mkIf system.virtualisation.podman.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = system.virtualisation.podman.docker-compat;
      defaultNetwork.settings.dns_enabled = true;
    };

    users.users.${user.name}.extraGroups = [ "podman" ];

    environment.systemPackages =
      with pkgs;
      mkIf system.virtualisation.podman.podman-desktop [
        podman-desktop
      ];
  };
}
