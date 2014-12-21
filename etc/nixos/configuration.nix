# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{ # My default config, compare this to live-configuration.nix
  imports =
    [ ./bare-configuration.nix
      ./prog-languages.nix
      ./hardware-configuration.nix # Removed
      ./custom-hardware-configuration.nix # Removed
      ./x11-configuration.nix
      ./tex-configuration.nix
      ./networking-configuration.nix
      ./containers.nix
    ];
}
