{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) system cli;

  aliases = import ../aliases.nix;
in
{
  options.my.system.shell.zsh = {
    enable = mkEnableOption "ZSH shell";
  };

  config = mkIf system.shell.zsh.enable {
    programs.zsh = {
      enable = true;

      shellAliases = {
        nfu = "cd ~/nix-config && sudo nix flake update";
      }
      // optionalAttrs cli.git.enable {
        inherit (aliases) git;
      }
      // optionalAttrs system.utils.enable {
        inherit (aliases) bat eza;
      };
    };
  };
}
