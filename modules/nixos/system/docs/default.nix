{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.docs = {
    enable = mkEnableOption "Documentations generation";
    doc = mkEnableOption "doc documentation";
    man = mkEnableOption "man documentation";
    dev = mkEnableOption "dev documentation";
    info = mkEnableOption "info documentation";
    nixos = mkEnableOption "nixos documentation";
  };

  config = mkIf system.docs.enable {
    documentation = {
      enable = true;

      doc.enable = system.docs.doc;
      man.enable = system.docs.man;
      dev.enable = system.docs.dev;
      info.enable = system.docs.info;
      nixos.enable = system.docs.nixos;
    };
  };
}
