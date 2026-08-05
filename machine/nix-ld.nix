# Puts a working loader at /lib64/ld-linux-x86-64.so.2, where NixOS otherwise
# keeps a stub that only prints "this binary is not for NixOS". Without it every
# binary built for an ordinary distro refuses to start: the Pythons uv
# downloads, language servers editors fetch themselves, npm and bun binaries.
#
# Native nix programs never touch this path — their loader is baked in at build
# time — so nothing already working can break here.
#
# When something still fails with "libfoo.so.N: cannot open shared object file",
# the fix is to add that library below. The module's default list already covers
# zlib, openssl, curl, systemd and libstdc++ (as stdenv.cc.cc).
{ ... }:
{
  programs.nix-ld.enable = true;
}
