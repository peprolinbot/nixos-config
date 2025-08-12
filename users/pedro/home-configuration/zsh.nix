{pkgs, ...}: {
  home.packages = with pkgs; [fzf git gtrash]; # Required packages

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
    };

    shellAliases = {
      # Utils
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      icat = "kitten icat";
      open = "xdg-open";

      # Git
      ga = "git add";
      gaa = "git add --all";
      gs = "git status";
      gb = "git branch";
      gm = "git merge";
      gpl = "git pull";
      gplo = "git pull origin";
      gps = "git push";
      gpst = "git push --follow-tags";
      gpso = "git push origin";
      gc = "git commit";
      gcm = "git commit -m";
      gcma = "git add --all && git commit -m";
      gtag = "git tag -ma";
      gch = "git checkout";
      gchb = "git checkout -b";
      gcoe = "git config user.email";
      gcon = "git config user.name";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";

      # ssh
      s = "kitten ssh";
      kssh = "kitten ssh";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship.enable = true;

  programs.fzf.enable = true;
}
