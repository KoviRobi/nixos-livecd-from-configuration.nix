# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{ time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n =
  { consoleFont = "LatArCyrHeb-16";
    consoleKeyMap = "hu";
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [ "hu_HU.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  environment.variables.EDITOR = pkgs.lib.mkOverride 1 "vim";
  environment.variables.PAGER = pkgs.lib.mkOverride 1 "less -Rq";
  environment.variables.LC_ALL = "en_GB.UTF-8";
  environment.variables.TERMCMD = "urxvt";

  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP '*' | grep wget
  environment.systemPackages = with pkgs;
  [ shadow
    file
    gcc
    git
    gmpc
    gnumake
    grub
    irssi
    mpd
    mpv
    mutt
    ssmtp
    pulseaudioFull
    pv
    ranger
    sudo
    tmux
    tree
    vim
    zsh
    ctags
    remind
    fortune
    readline
    ncurses
    gnupg
    gnupg1compat
    pinentry
    plan9port
    which
    pmutils
    offlineimap
    tor
    torsocks
    unzip
    colordiff
    psmisc
    ffmpeg
    libaacs
    aacskeys
    fuse_exfat
    toxic
  ];

  # List services that you want to enable:
  services =
  { openssh =
    { enable = false;
      permitRootLogin = "no";
    };

    printing.enable = true;

    mpd =
    { enable = true;
      musicDirectory = "/music";
      extraConfig =
      ''
      audio_output {
          type            "pulse"
          name            "PulseAudio"
          server          "127.0.0.1"             # optional
          # sink          "remote_server_sink"    # optional
      }

      zeroconf_name "rmk35's Music Player Daemon"
      # password "" # TODO: set password for mpd control if needed

      audio_output {    
        type      "httpd"    
        name      "rmk35's Music Player Daemon Stream"
        encoder   "vorbis"  # optional, vorbis or lame
        port      "8123"
      # quality   "5.0"     # do not define if bitrate is defined
        bitrate   "128"     # do not define if quality is defined
        format    "44100:16:1"
      }
      '';
    };
  };
  networking.firewall.allowedTCPPorts = [ 6600 8123 ];

  # Not needed since using ip-auth-acl
  ## Automatically copy pulse cookie to mpd
  #systemd.services.mpd.preStart = "cp ~kr2/.config/pulse/cookie ~mpd/.config/pulse/cookie; chown mpd:mpd ~mpd/.config/pulse/cookie";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  sound.enableOSSEmulation = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.kr2 =
  { name = "kr2";
    group = "users";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    uid = 1000;
    createHome = true;
    home = "/home/kr2";
    shell = "/run/current-system/sw/bin/zsh";
    # hashedPassword = ""; # TODO: Set password
  };

  users.mutableUsers = false;

  # security.initialRootPassword = ""; # TODO: Set password

  security.sudo.configFile =
  ''
  Defaults passprompt="[sudo] password for %p@%H: "
  '';

  services.udev.extraRules =
  ''
  SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="2", RUN+="/run/current-system/sw/bin/systemctl suspend"
  SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="1", RUN+="/run/current-system/sw/bin/systemctl suspend"
  SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="0", RUN+="/run/current-system/sw/bin/systemctl suspend"
  '';
}
