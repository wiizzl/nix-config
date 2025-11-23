{ inputs, ... }:

{
  # Fixes dolphin dependency issues (MIME apps, ...)
  nixpkgs.overlays = [ inputs.dolphin-overlay.overlays.default ];
}
