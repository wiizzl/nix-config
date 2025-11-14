{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) user;
in
{
  options.my.user = {
    name = mkOpt types.str "nixos" "User account name";
    homeDir = mkOpt types.str "/home/${user.name}" "Home directory path";
  };

  config = mkIf user.enable {
    nix.settings.trusted-users = [ "${user.name}" ];

    users.users.${user.name} = {
      isNormalUser = true;
      createHome = true;
      hashedPasswordFile = config.age.secrets.password.path;
      description = "${user.name} account";
      extraGroups = [ "wheel" ];
    };
  };
}
