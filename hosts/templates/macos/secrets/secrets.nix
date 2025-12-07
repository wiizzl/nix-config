let
  macos = "<your-public-key>";
in
{
  # You can generate age keys with `nix run github:ryantm/agenix -- -e <key-name>.age`
  "password.age".publicKeys = [ macos ];
  "tailscale.age".publicKeys = [ macos ];
}
