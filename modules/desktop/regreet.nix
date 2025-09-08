{pkgs, ...}: {
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;
        fit = "Cover";
      };
    };
    cageArgs = ["-s" "-m" "last"]; # Only show on the last monitor
  };
}
