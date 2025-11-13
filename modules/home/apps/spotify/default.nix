{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{

  options.my.apps.spotify = {
    enable = mkEnableOption "Spotify with Spicetify";
  };

  config = mkIf apps.spotify.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.spicetify-nix.homeManagerModules.default ];

      programs.spicetify =
        let
          spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          enable = true;

          enabledExtensions = with spicePkgs.extensions; [
            hidePodcasts
            adblock
            shuffle
          ];

          enabledCustomApps = with spicePkgs.apps; [
            historyInSidebar
          ];

          enabledSnippets = with spicePkgs.snippets; [
            rotatingCoverart
          ];
        };
    };
  };
}
