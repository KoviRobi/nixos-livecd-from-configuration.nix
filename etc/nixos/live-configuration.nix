# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{ 
  # Replace these with yours, I only included them for convenience
  imports =
  [ ./bare-configuration.nix
    ./prog-languages.nix
    ./x11-configuration.nix
    ./tex-configuration.nix
    ./networking-configuration.nix
    ./containers.nix
  ];

  # Override this from the installation-cd-rmk35.nix included option, as I want sudo
  security.sudo.enable = true;
  # Override this from the installation-cd-rmk35.nix included option, as I want wireless
  networking.wireless.enable = lib.mkOverride 80 false;
  # Override this from bare-configuration.nix which defines (non-mutable) users
  users.extraUsers.kr2.home = lib.mkOverride 80 "/iso/home/kr2";
}
