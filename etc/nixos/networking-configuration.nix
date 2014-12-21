# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=nix nocompatible :
{ config, pkgs, ... }:

{ networking =
  { hostName = "rmk35";
    firewall.enable = true;
    firewall.allowPing = true;
    firewall.rejectPackets = true;
    nameservers = [ "127.0.0.1" ];
    networkmanager.enable = true;
    networkmanager.packages = with pkgs;
    [ networkmanager_vpnc
      networkmanager_openvpn
      networkmanager_pptp
      gnome3_12.networkmanager_pptp
    ];
  };

  environment.systemPackages = with pkgs;
  [ unbound
    wget
    networkmanager
    networkmanagerapplet
    networkmanager_vpnc
    networkmanager_openvpn
    networkmanager_pptp
    gnome3_12.networkmanager_pptp
  ];

  systemd.services.unbound.enable = true;
  services =
  { unbound = 
    { enable = true;
      extraConfig = "include: /etc/unbound-resolvconf.conf";
      allowedAccess = [ "127.0.0.0/24" "192.168.100.0/24" ];
      interfaces = [ "0.0.0.0" "::0" ];
    };

    avahi =
    { enable = true;
      browseDomains = [];
      wideArea = false;
      nssmdns = true;
    };

    ntp.enable = true;
  };

  environment.etc."resolvconf.conf" =
  { text =
    ''
    unbound_conf=/etc/unbound-resolvconf.conf
    '';
  };
}
