{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
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
      };
    };
  };
}
