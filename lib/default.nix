{ lib, ... }:

with lib;
{
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  mkOpt' = type: mkOption { inherit type; };
  mkOpt_ = type: description: mkOption { inherit type description; };

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };
}
