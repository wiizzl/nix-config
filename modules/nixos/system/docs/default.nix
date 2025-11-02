{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  inherit (config.my) system;
in
{
  options.my.system.docs = {
    enable = mkEnableOption "Enable documentation generation";
    doc = mkOption {
      type = types.bool;
      default = false;
    };
    man = mkOption {
      type = types.bool;
      default = false;
    };
    dev = mkOption {
      type = types.bool;
      default = false;
    };
    info = mkOption {
      type = types.bool;
      default = false;
    };
    nixos = mkOption {
      type = types.bool;
      default = false;
    };
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
