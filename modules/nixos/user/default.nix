{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) user;
in
{
  options.my.user = {
    enable = mkEnableOption "user configuration";
    name = mkOpt types.str "pier" "User account name";
    homeDir = mkOpt types.str "/home/${user.name}" "Home directory path";
    home-manager.enable = mkEnableOption "home-manager";
    shell = mkOption {
      description = "Shell configuration";
      type = types.submodule {
        options = {
          package = mkOpt types.package pkgs.bash "Shell package";
          starship.enable = mkEnableOption "starship prompt";
        };
      };
    };
  };

  config = mkIf user.enable {
    nix.settings.trusted-users = [ "${user.name}" ];

    users.users.${user.name} = {
      isNormalUser = true;
      createHome = true;
      description = "${user.name} account";
      extraGroups = [ "wheel" ];
      shell = user.shell.package;
    };
  };
}
