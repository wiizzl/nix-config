{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) user;
in
{
  config = mkIf user.shell.starship.enable {
    home-manager.users.${user.name} =
      { config, ... }:
      {
        xdg.configFile."starship.toml" = {
          source = config.lib.file.mkOutOfStoreSymlink "${user.homeDir}/nix-config/modules/home/apps/user/starship/config/starship.toml";
        };

        programs.starship = {
          enable = true;

          settings = {
            add_newline = false;
            buf = {
              symbol = " ";
            };
            c = {
              symbol = " ";
            };
            directory = {
              read_only = " 󰌾";
            };
            docker_context = {
              symbol = " ";
            };
            fossil_branch = {
              symbol = " ";
            };
            git_branch = {
              symbol = " ";
            };
            golang = {
              symbol = " ";
            };
            hg_branch = {
              symbol = " ";
            };
            hostname = {
              ssh_symbol = " ";
            };
            lua = {
              symbol = " ";
            };
            memory_usage = {
              symbol = "󰍛 ";
            };
            meson = {
              symbol = "󰔷 ";
            };
            nim = {
              symbol = "󰆥 ";
            };
            nix_shell = {
              symbol = " ";
            };
            nodejs = {
              symbol = " ";
            };
            ocaml = {
              symbol = " ";
            };
            package = {
              symbol = "󰏗 ";
            };
            python = {
              symbol = " ";
            };
            rust = {
              symbol = " ";
            };
            swift = {
              symbol = " ";
            };
            zig = {
              symbol = " ";
            };
          };
        };
      };
  };
}
