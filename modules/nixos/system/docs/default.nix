{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.docs = {
    enable = mkEnableOption "Documentations generation";
    doc.enable = mkEnableOption "doc documentation";
    man.enable = mkEnableOption "man documentation";
    dev.enable = mkEnableOption "dev documentation";
    info.enable = mkEnableOption "info documentation";
    nixos.enable = mkEnableOption "nixos documentation";
  };

  config = mkIf system.docs.enable {
    documentation = {
      enable = true;

      doc.enable = system.docs.doc.enable;
      man.enable = system.docs.man.enable;
      dev.enable = system.docs.dev.enable;
      info.enable = system.docs.info.enable;
      nixos.enable = system.docs.nixos.enable;
    };
  };
}
