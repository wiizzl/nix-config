{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.libvirtd = {
    enable = mkEnableOption "libvirtd";
    virt-manager.enable = mkEnableOption "virt-manager GUI";
  };

  config = mkIf system.virtualisation.libvirtd.enable {
    virtualisation.libvirtd = {
      enable = true;
    };

    users.users.${user.name}.extraGroups = [ "libvirtd" ];
    programs.virt-manager.enable = system.virtualisation.libvirtd.virt-manager.enable;
  };
}
