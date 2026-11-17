{ ... }:

{
  services.fprintd.enable = true;
  # fingerprint for sudo
  security.pam.services.sudo.fprintAuth = true;
}
