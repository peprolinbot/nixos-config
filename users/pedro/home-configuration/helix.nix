{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server = {
        pyright = {
          command = "${pkgs.pyright}/bin/pyright-langserver";
          args = [ "--stdio" ];
          config = { };
        };

        nil = {
          command = "${pkgs.nil}/bin/nil";
        };

        vscode-json-language-server.command = "${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver";
      };

      language = [
        {
          name = "nix";
          language-servers = [ "nil" ];
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }

        {
          name = "python";
          language-servers = [ "pyright" ];
          auto-format = true;
          formatter = {
            command = "${pkgs.black}/bin/black";
            args = [
              "--quiet"
              "-"
            ];
          };
        }
        {
          name = "json";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = [
              "--parser"
              "json"
            ];
          };
        }
      ];
    };
    settings = {
      editor = {
        bufferline = "always";
      };
    };
  };
}
