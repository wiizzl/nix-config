{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.yazi = {
    enable = mkEnableOption "Yazi file explorer";
  };

  config = mkIf cli.yazi.enable {
    home-manager.users.${user.name} = {
      programs.yazi = {
        enable = true;

        settings = {
          mgr = {
            ratio = [
              1
              4
              3
            ];
            sort_by = "alphabetical";
            sort_sensitive = false;
            sort_reverse = false;
            sort_dir_first = true;
            sort_translit = false;
            linemode = "none";
            show_hidden = false;
            show_symlink = true;
            scrolloff = 5;
            mouse_events = [
              "click"
              "scroll"
            ];
            title_format = "Yazi: {cwd}";
          };
          preview = {
            wrap = "no";
            tab_size = 2;
            max_width = 600;
            max_height = 900;
            cache_dir = "";
            image_delay = 30;
            image_filter = "triangle";
            image_quality = 75;
            sixel_fraction = 15;
            ueberzug_scale = 1;
            ueberzug_offset = [
              0
              0
              0
              0
            ];
          };
          tasks = {
            micro_workers = 10;
            macro_workers = 10;
            bizarre_retry = 3;
            image_alloc = 536870912;
            image_bound = [
              0
              0
            ];
            suppress_preload = false;
          };
          input = {
            cursor_blink = false;
            cd_title = "Change directory:";
            cd_origin = "top-center";
            cd_offset = [
              0
              2
              50
              3
            ];
            create_title = [
              "Create:"
              "Create (dir):"
            ];
            create_origin = "top-center";
            create_offset = [
              0
              2
              50
              3
            ];
            rename_title = "Rename:";
            rename_origin = "hovered";
            rename_offset = [
              0
              1
              50
              3
            ];
            filter_title = "Filter:";
            filter_origin = "top-center";
            filter_offset = [
              0
              2
              50
              3
            ];
            find_title = [
              "Find next:"
              "Find previous:"
            ];
            find_origin = "top-center";
            find_offset = [
              0
              2
              50
              3
            ];
            search_title = "Search via {n}:";
            search_origin = "top-center";
            search_offset = [
              0
              2
              50
              3
            ];
            shell_title = [
              "Shell:"
              "Shell (block):"
            ];
            shell_origin = "top-center";
            shell_offset = [
              0
              2
              50
              3
            ];
          };
          confirm = {
            trash_title = "Trash {n} selected file{s}?";
            trash_origin = "center";
            trash_offset = [
              0
              0
              70
              20
            ];
            delete_title = "Permanently delete {n} selected file{s}?";
            delete_origin = "center";
            delete_offset = [
              0
              0
              70
              20
            ];
            overwrite_title = "Overwrite file?";
            overwrite_content = "Will overwrite the following file:";
            overwrite_origin = "center";
            overwrite_offset = [
              0
              0
              50
              15
            ];
            quit_title = "Quit?";
            quit_content = "The following tasks are still running, are you sure you want to quit?";
            quit_origin = "center";
            quit_offset = [
              0
              0
              50
              15
            ];
          };
          pick = {
            open_title = "Open with:";
            open_origin = "hovered";
            open_offset = [
              0
              1
              50
              7
            ];
          };
          which = {
            sort_by = "none";
            sort_sensitive = false;
            sort_reverse = false;
            sort_translit = false;
          };
        };

        plugins = {
          lazygit = pkgs.yaziPlugins.lazygit;
          full-border = pkgs.yaziPlugins.full-border;
          git = pkgs.yaziPlugins.git;
          smart-enter = pkgs.yaziPlugins.smart-enter;
        };
      };
    };
  };
}
