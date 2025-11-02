{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.podman = {
    enable = mkEnableOption "Podman engine";
    docker-compat = mkEnableOption "Docker compatibility mode";
    podman-desktop = mkEnableOption "Podman Desktop GUI";
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
