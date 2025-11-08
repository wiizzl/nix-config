let
  pier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyWE+mk3eu5C0XdV9oCOHULBcnQT4BVUdq4YBZLugnI";
in
{
  # You can generate age keys with `nix run github:ryantm/agenix -- -e <key-name>.age`
  "password.age".publicKeys = [ pier ];
  "tailscale.age".publicKeys = [ pier ];
}
