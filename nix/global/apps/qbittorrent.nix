{ inputs, config, lib, pkgs, baseVars, ... }:

let
  namespace = {
    name = "qbit";
    address = "192.168.15.78";
    torrentPort = 60729;
    webuiPort = 7880;
  };
in
{
  imports = [ inputs.vpn-confinement.nixosModules.default ];

  services.qbittorrent = {
    enable = true;
    torrentingPort = namespace.torrentPort;
    webuiPort = namespace.webuiPort;
    serverConfig =  {
      LegalNotice.Accepted = true;
      Preferences = {
        General.Locale = "en";
        WebUI = {
          Username = "luci";
          Password_PBKDF2 = "QdRPvU0ljx7SZMQ3BlIN1A==:JwQoYiJAMjj9IyHCok6kmPxspb2ONiDA8r4GX5dBcvVpF0ngg0hkYU++7yap+JpTDr4S6UvwzPaHGfQiBeknfA==";
        };
      };
    };
  };

  # default to downloading to ~/torrent
  services.qbittorrent.serverConfig.BitTorrent.Session.DefaultSavePath = "/srv/torrent";
  systemd.tmpfiles.rules = with { qbit = config.services.qbittorrent; }; [
    "d /srv/torrent 0775 ${qbit.user} ${qbit.group} -"
    "L+ /home/${baseVars.username}/torrent - - - - /srv/torrent"
  ];

  # isolate qbittorrent service to vpn
  vpnNamespaces.${namespace.name} = {
    enable = true;
    wireguardConfigFile = config.age.secrets.wg0.path;
    allowedIngress = [ "192.168.0.0/24" ];
    namespaceAddress = namespace.address;
    portMappings = [ namespace.webuiPort ];
    vpn.allowedTCPPorts = [ namespace.torrentPort ];
    vpn.allowedUDPPorts = [ namespace.torrentPort ];
  };
  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = namespace.name;
  };

  # qbit needs to be on localhost to associate with magnet links
  # localhost:${namespace.webuiPort} -> ${namespace.address}:${namespace.webuiPort}
  systemd.sockets.qbittorrent-localhost-proxy = {
    wantedBy = [ "sockets.target" ];
    listenStreams = [ "127.0.0.1:${toString namespace.webuiPort}" ];
  };
  systemd.services.qbittorrent-localhost-proxy = {
    requires = [ "qbittorrent.service" "qbittorrent-localhost-proxy.socket" ];
    after = [ "qbittorrent.service" "qbittorrent-localhost-proxy.socket" ];
    serviceConfig = {
      ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd ${namespace.address}:${toString namespace.webuiPort}";
      PrivateTmp = true;
    };
  };

  # dont hold up launch of graphical session
  systemd.targets.background-network = {
    description = "Background network services";
    wantedBy = [ "multi-user.target" ];
    unitConfig.DefaultDependencies = false;
  };
  systemd.services.qbittorrent.wantedBy = lib.mkForce [ "background-network.target" ];
  systemd.services.${namespace.name}.wantedBy = lib.mkForce [ "background-network.target" ];

  environment.systemPackages = [(pkgs.makeDesktopItem {
    name = "qbittorrent";
    desktopName = "qBitTorrent";
    exec = "xdg-open http://localhost:${toString namespace.webuiPort}";
    icon = "qbittorrent";
  })];
}
