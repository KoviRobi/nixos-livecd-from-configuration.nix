# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
{ config, pkgs, ... }:

{ # List packages installed in system profile. To search by name, run:
  # nix-env -qaP '*' | grep `name'
  environment.systemPackages = with pkgs;
  [ texLiveFull
    asymptote
  ];
}
