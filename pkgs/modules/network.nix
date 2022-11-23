{
  etc.sslCertificates.enable = true;
  bubblewrap = {
    bind.ro = [ "/etc/resolv.conf" ];
    network = true;
  };
}
