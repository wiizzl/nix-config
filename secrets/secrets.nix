let
  pier = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBuhGpkusmMSzJZL/gfl+k0ytUUWBean705sk4l1UzY";
in
{
  "password.age".publicKeys = [ pier ];
  "tailscale.age".publicKeys = [ pier ];
}
