{ inputs, ... }:

let
  vscodeExtensions = final: prev: {
    nix-vscode-extensions = import inputs.nix-vscode-extensions.overlays.default {
      system = "${prev.system}";
      config.allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = [ vscodeExtensions ];
}
