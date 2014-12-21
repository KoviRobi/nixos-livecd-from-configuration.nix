# This module contains the basic configuration for building a NixOS
# installation CD.

{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    [ /home/kr2/.nix-defexpr/channels/nixos/nixos/modules/installer/cd-dvd/channel.nix
      ./iso-image-rmk35.nix

      # Profiles of the basic installation CD.
      # Replaced relative paths with absolute, as I have the patched file elsewhere
      /home/kr2/.nix-defexpr/channels/nixos/nixos/modules/profiles/all-hardware.nix
      /home/kr2/.nix-defexpr/channels/nixos/nixos/modules/profiles/base.nix
      /home/kr2/.nix-defexpr/channels/nixos/nixos/modules/profiles/installation-device.nix

      # System configuration
      /etc/nixos/live-configuration.nix
    ];

  # ISO naming.
  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixosVersion}-${pkgs.stdenv.system}.iso";

  isoImage.volumeID = substring 0 11 "NIXOS_ISO";

  # Make the installer more likely to succeed in low memory
  # environments.  The kernel's overcommit heustistics bite us
  # fairly often, preventing processes such as nix-worker or
  # download-using-manifests.pl from forking even if there is
  # plenty of free memory.
  boot.kernel.sysctl."vm.overcommit_memory" = "1";

  # To speed up installation a little bit, include the complete stdenv
  # in the Nix store on the CD.  Archive::Cpio is needed for the
  # initrd builder.
  isoImage.storeContents = [ pkgs.stdenv pkgs.busybox pkgs.perlPackages.ArchiveCpio ];

  # EFI booting
  isoImage.makeEfiBootable = true;

  # Add Memtest86+ to the CD.
  boot.loader.grub.memtest86.enable = true;

  # Get a console as soon as the initrd loads fbcon on EFI boot
  # I have my files on a UDF partition, hence need UDF
  boot.initrd.kernelModules = [ "fbcon" "udf" ];

  # Add support for cow filesystems and their utilities
  boot.supportedFilesystems = [ "zfs" "btrfs" ];

  # Configure host id for ZFS to work
  networking.hostId = "8425e349";

  # Allow the user to log in as root without a password.
  users.extraUsers.root.initialHashedPassword = "";
}
