let
  pier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyWE+mk3eu5C0XdV9oCOHULBcnQT4BVUdq4YBZLugnI";
in
{
  "password.age".publicKeys = [ pier ];
  "tailscale.age".publicKeys = [ pier ];
}
