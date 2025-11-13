{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;

  inherit (config.my) user;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.my.user.home-manager = {
    userDirs.enable = mkEnableOption "manage home directories via home-manager";
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = {
        inherit inputs;
        inherit user;
      };

      users.${user.name} = {
        home = {
          username = user.name;
          homeDirectory = user.homeDir;
          stateVersion = "25.05";
        };

        xdg.userDirs = mkIf user.home-manager.usersDir.enable {
          enable = true;
          createDirectories = true;
        };
      };
    };
  };
}
