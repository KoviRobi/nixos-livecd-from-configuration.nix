# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
# Programming languages

{ config, pkgs, ... }:

{ environment.systemPackages = with pkgs;
  [ gcc     # Also in bare-configuration.nix
    manpages
    stdmanpages
    gdb

    astyle

    gnuplot
    graphviz
    maxima
    wxmaxima
    octave

    tk
    tcl
    tcllib
    ats2

    gnumake # Also in bare-configuration.nix
    zsh     # Also in bare-configuration.nix
    ctags   # Also in bare-configuration.nix
    remind  # Also in bare-configuration.nix

    openjdk
    rlwrap
    polyml
    python
    guile
    clisp
    pltScheme
    ruby

    inferno
    plan9port # Also in bare-configuration.nix
  ];
}
