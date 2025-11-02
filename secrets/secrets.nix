let
  pier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII/5JRzhMTgejHanyUKYJUjTpbTMlBOIUatYuhMvNFC7 pier@nixos";
in
{
  "password.age".publicKeys = [ pier ];
  "tailscale.age".publicKeys = [ pier ];
}
