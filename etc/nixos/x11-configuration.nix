# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
{ config, pkgs, ... }:

{ hardware.bumblebee.enable = true;
  hardware.opengl.driSupport = true;

  fonts = 
  { fontconfig =
    { enable = true;
      ultimate.enable = true;
      includeUserConf = true;
    };
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs;
    [ inconsolata
      dejavu_fonts
      liberation_ttf
    ];
  };

  environment.systemPackages = with pkgs;
  [ chromium
    firefoxWrapper
    (pkgs.conky.override
    { x11Support = true;
      wireless = true;
      rss = true;
      weatherMetar = true;
      weatherXoap = true;
      mpdSupport = true;
    })
    dzen2
    ttmkfdir
    xfontsel
    libnotify
    clipit
    parcellite
    pavucontrol
    rxvt_unicode
    trayer
    hicolor_icon_theme
    gnome.gnome_icon_theme
    tango-icon-theme
    vimHugeX
    xdotool
    x11_ssh_askpass
    xscreensaver
    mesa
    mesa_drivers
    glxinfo
    vaapiIntel
    zathura
    zathuraCollection.zathura_ps
    zathuraCollection.zathura_djvu
    zathuraCollection.zathura_pdf_poppler
    gv
    gitFull # includes gitk
    python27Packages.udiskie

    (pkgs.pidgin-with-plugins.override
    { plugins = [ pidginlatex pidginotr toxprpl ];
    })
    pidginlatex
    pidginotr
    toxprpl

    utox

    # For gsettings
    glib
    gnome3.dconf
    gnome3.gsettings_desktop_schemas
  ] ++
  (with pkgs.xlibs;
  [ xmessage
    xbacklight
    xf86videointel
    xauth
    xkbprint
    xmodmap
    xorgdocs
    xf86inputsynaptics
  ]);

  nixpkgs.config =
  {  firefox =
     { enableAdobeFlash = true;
       enablePepperFlash = true;
       enablePepperPDF = true;
       enableGoogleTalkPlugin = true;
     };
     chromium =
     { enableAdobeFlash = true;
       enablePepperFlash = true;
       enablePepperPDF = true;
       enableGoogleTalkPlugin = true;
     };
  };

  # Session pre-start
  services =
  { xserver =
    { enable = true;

      videoDrivers = [ "intel" ];
      driSupport = true;

      # desktopManager.xfce.enable = true;
      desktopManager.default = "none";
      windowManager.awesome.enable = true;
      windowManager.default = "awesome";

      layout = "hu(102_qwertz_dot_dead), us(intl)";
      xkbModel = "ibm_spacesaver";
      xkbOptions = "grp:shifts_toggle, grp_led:scroll, compose:menu, terminate:ctrl_alt_bksp, caps:swapescape, keypad:pointerkeys";
      xrandrHeads = [ "LVDS1" "HDMI1" ];

      exportConfiguration = true;

      config =
      ''
      # mousedrv(4)
      # vi: sw=4 ts=4 sts=4 et

      Section "InputClass"
          Identifier "touchpad catchall"
          Driver "synaptics"
          MatchIsTouchpad "on"
          MatchDevicePath "/dev/input/event*"
              Option "TapButton1" "1"
              Option "TapButton2" "2"
              Option "TapButton3" "3"
      EndSection 
      
      Section "InputClass"
          Identifier "Forward button scroll"
          MatchIsPointer "on"
          Option "EmulateWheel" "on"
          Option "EmulateWheelButton" "9"
          Option "EmulateWheelInertia" "5"
          Option "YAxisMapping" "4 5"
          Option "XAxisMapping" "6 7"
      EndSection
      
      Section "InputClass"
          Identifier "Logitech M570"
          MatchProduct "Logitech Unifying Device. Wireless PID:1028"
          Option "Buttons" "5"
          Option "Sensitivity" "0.176"
      EndSection
      
      Section "InputClass"
          Identifier "Logitech TrackMan Marble"
          MatchProduct "Logitech USB Trackball"
          Option "Emulate3Buttons" "on"
          Option "EmulateWheelInertia" "7"
      EndSection
      '';

      deviceSection = ''Option "Backlight"  "intel_backlight"'';

      displayManager =
      { sessionCommands =
        ''
        source ~/.xinitrc-local || true;
        xrdb -merge ~/.Xresources;
        rem -z -k'notify-send -a Reminder %s'&
        clipit &
        nm-applet &
        xscreensaver -no-splash &
        udiskie --tray &
        { while true; do offlineimap; sleep 5m; done } &
        '';

        lightdm.enable = true;

        # Get lid suspend for minimalist window managers
        desktopManagerHandlesLidAndPower = false;
      };

      synaptics =
      { enable = true;
        palmDetect = true;
        twoFingerScroll = true;
        additionalOptions =
        ''
          Option "CircularScrolling" "true"
        '';
      };
    };

    # redshift =
    # { enable = true;
    #   brightness.day = "1.0";
    #   brightness.night = "0.9";
    #   latitude = "52.2";
    #   longitude = "0.12";
    # };

    gnome3.gnome-keyring.enable = true;
  };

  powerManagement.resumeCommands = "/run/current-system/sw/bin/xscreensaver-command -lock";
}
