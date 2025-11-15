{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) cli user;
in
{
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
    };
  };
}
