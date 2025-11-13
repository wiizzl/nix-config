{ pkgs, inputs, ... }:

let
  vscodeExtensions = {
    nix-vscode-extensions = import inputs.nix-vscode-extensions.overlays.default {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
}
