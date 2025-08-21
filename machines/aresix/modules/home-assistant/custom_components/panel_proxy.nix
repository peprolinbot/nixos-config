{
  stdenv,
  pkgs,
  fetchFromGitHub,
  buildHomeAssistantComponent,
}:
buildHomeAssistantComponent rec {
  owner = "jimparis";
  domain = "panel_proxy";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "jimparis";
    repo = "hass-panel-proxy";
    rev = "e5421e013b7aa011609f7e7be9f0c2c017f029df";
    sha256 = "sha256-eq1sZmZBpRGOyhDduT40z+xhbq5DD1hgz9jSyKhX8QI=";
  };
}
