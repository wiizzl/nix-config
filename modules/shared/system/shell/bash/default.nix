{ config, lib, ... }:

let

  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system cli;

  aliases = import ../aliases.nix;
in
{
  options.my.system.shell.bash = {
    enable = mkEnableOption "Bash shell";
  };

  config = mkIf system.shell.bash.enable {
    programs.bash = {
      enable = true;

      # shellAliases =
      #   (optionals system.utils.enable (aliases.eza // aliases.bat))
      #   // (optionals cli.git.enable aliases.git)
      #   // {
      #   };

      shellAliases = {
        nfu = "cd ~/nix-config && sudo nix flake update";
      };

      # bashrcExtra = ''
      #   nrs() {
      #     if [ -z "$1" ]; then
      #       echo "Usage: nrs <host> [additional nixos-rebuild args]" >&2
      #       return 1
      #     fi

      #     host="$1"
      #     shift

      #     nixos-rebuild switch --sudo --flake "$HOME/nix-config#$host" "$@"
      #   }

      #   nd() {
      #     if [ -z "$1" ]; then
      #       echo "Usage: nd <shell> [additional nix develop args]" >&2
      #       return 1
      #     fi

      #     shell="$1"
      #     shift

      #     nix develop "$HOME/nix-config#$shell" "$@"
      #   }
      # '';
    };
  };
}
