let
  pier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJEWBWKmH94FDB6oaI4J60GwAnVqScvXNN89GJtFiBOv";
in
{
  # You can generate age keys with `nix run github:ryantm/agenix -- -e <key-name>.age`
  "password.age".publicKeys = [ pier ];
  "tailscale.age".publicKeys = [ pier ];
}
