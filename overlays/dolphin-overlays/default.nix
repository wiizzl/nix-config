{ inputs, ... }:

{
  nixpkgs.overlays = [ inputs.dolphin-overlay.overlays.default ];
}
