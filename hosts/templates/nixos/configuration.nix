{ ... }:

{
  imports = [
    # You need to generate this file with `nixos-generate-config`.
    # See https://wiki.nixos.org/wiki/Nixos-generate-config
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    ../../modules/shared/import.nix
    ../../modules/home/import.nix
  ];

  config = {
    # TODO: NixOS template config
  };
}
