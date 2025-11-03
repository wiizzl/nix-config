{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli;
in
{
  options.my.cli.nix-ld = {
    enable = mkEnableOption "nix-ld";
  };

  config = mkIf cli.nix-ld.enable {
    imports = [ inputs.nix-ld.nixosModules.nix-ld ];

    programs.nix-ld.dev.enable = true;
  };
}
