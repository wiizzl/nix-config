{ inputs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ./variables.nix
  ];
}
