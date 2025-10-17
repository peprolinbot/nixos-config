{pkgs, ...}: {
  services.kanidm = {
    enableServer = true;
    enableClient = true;

    package = pkgs.kanidm_1_7;

    serverSettings = {
      version = "2"; # Configuration file version.
      origin = "https://idm.peprolinbot.com";
      domain = "idm.peprolinbot.com";
      bindaddress = "[::1]:8443";
      ldapbindaddress = "[::]:636";
      http_client_address_info.x-forward-for = ["::1"];
      tls_chain = "/var/lib/kanidm/cert.pem";
      tls_key = "/var/lib/kanidm/key.pem";
    };

    clientSettings = {
      uri = "https://idm.peprolinbot.com";
    };
  };

  security.acme.certs."idm.peprolinbot.com" = {
    postRun = ''
      cp -Lv {cert,key,chain}.pem /var/lib/kanidm/
      chown kanidm:kanidm /var/lib/kanidm/{cert,key,chain}.pem
      chmod 400 /var/lib/kanidm/{cert,key,chain}.pem
    '';
    reloadServices = ["kanidm.service"];
  };
}
