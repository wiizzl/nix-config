{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nwg-look
    arc-theme
  ];
}
