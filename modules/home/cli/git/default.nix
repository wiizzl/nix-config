{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.extraMkOptions) mkOpt_;

  inherit (config.my) cli user;
in
{
  options.my.cli.git = {
    enable = mkEnableOption "git";
    name = mkOpt_ types.str "Git user name";
    email = mkOpt_ types.str "Git user email";
    lazygit.enable = mkEnableOption "lazygit TUI";
    gh.enable = mkEnableOption "GitHub CLI";
  };

  config = mkIf cli.git.enable {
    home-manager.users.${user.name} = {
      programs.git = {
        enable = true;

        settings = {
          user = {
            name = cli.git.name;
            email = cli.git.email;
          };

          url = {
            "git@github.com:".insteadOf = [
              "gh:"
              "https://github.com/"
            ];
            "git@github.com:${cli.git.name}/".insteadOf = "me:";
          };

          init.defaultBranch = "main";
          pull.rebase = true;
        };
      };

      programs.gh = mkIf cli.git.gh.enable {
        enable = true;
      };

      programs.lazygit = mkIf cli.git.lazygit.enable {
        enable = true;
      };
    };
  };
}
