{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.services.openssh = {
    enable = mkEnableOption "OpenSSH";
  };

  config = mkIf system.services.openssh.enable {
    programs.ssh.startAgent = true;
    services.gnome.gcr-ssh-agent.enable = false;

    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
