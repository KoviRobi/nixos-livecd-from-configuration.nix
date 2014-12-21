#!/bin/sh
sudo nix-build -A config.system.build.isoImage -I nixos-config=installation-cd-rmk35.nix $HOME/.nix-defexpr/channels/nixos/nixos/ $*
