{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionals;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.podman = {
    enable = mkEnableOption "Podman";
    docker-compat.enable = mkEnableOption "Docker compatibility mode";
    podman-desktop.enable = mkEnableOption "Podman Desktop GUI";
    distrobox.enable = mkEnableOption "Distrobox";
  };

  config = mkIf system.virtualisation.podman.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = system.virtualisation.podman.docker-compat.enable;
      defaultNetwork.settings.dns_enabled = true;
    };

    users.users.${user.name}.extraGroups = [ "podman" ];

    environment.systemPackages =
      with pkgs;
      optionals system.virtualisation.podman.podman-desktop.enable [
        podman-desktop
      ]
      ++ optionals system.virtualisation.podman.distrobox.enable [
        distrobox
      ];
  };
}
