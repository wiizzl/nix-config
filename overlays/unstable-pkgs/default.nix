{ inputs, ... }:

let
  unstablePkgs = final: prev: {
    unstable = import inputs.unstable-pkgs {
      inherit (prev) system;
      config.allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = [ unstablePkgs ];
}
