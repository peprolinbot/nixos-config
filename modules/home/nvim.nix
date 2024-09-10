{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
  home.packages = [pkgs.lunarvim];

  home.sessionPath = ["${pkgs.clang-tools}/bin:$PATH"];
}
