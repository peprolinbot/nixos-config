{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server = {
        pyright = {
          command = "${pkgs.pyright}/bin/pyright-langserver";
          args = ["--stdio"];
          config = {};
        };

        nil = {command = "${pkgs.nil}/bin/nil";};
      };

      language = [
        {
          name = "nix";
          language-servers = ["nil"];
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }

        {
          name = "python";
          language-servers = ["pyright"];
          auto-format = true;
          formatter = {
            command = "${pkgs.black}/bin/black";
            args = ["--quiet" "-"];
          };
        }
      ];
    };
    settings = {};
  };
}
