{pkgs, ...}: {
  home.packages = with pkgs; [lunarvim];

  programs.neovide = {
    enable = true;
    settings = {
      neovim-bin = "${pkgs.lunarvim}/bin/lvim";
    };
  };

  home.shellAliases = builtins.listToAttrs (map (key: {
      name = key;
      value = "lvim";
    })
    ["vi" "vim" "nvim"]);

  home.sessionPath = ["${pkgs.clang-tools}/bin:$PATH"];
}
