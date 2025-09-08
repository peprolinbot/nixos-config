{pkgs, ...}: {
  home.packages = with pkgs; [cmake black alejandra]; # The CMake extension needs it
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # nix language
        bbenoist.nix
        # nix-shell suport
        arrterian.nix-env-selector
        # nix formatting
        kamadorueda.alejandra
        # python
        ms-python.python
        ms-python.black-formatter
        # OCaml
        ocamllabs.ocaml-platform
        # CMake
        ms-vscode.cmake-tools
        # TOML
        tamasfe.even-better-toml

        # Theming
        catppuccin.catppuccin-vsc-icons
      ];

      userSettings = {
        "update.mode" = "none";
        "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update
        "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509

        "window.menuBarVisibility" = "toggle";
        "vsicons.dontShowNewVersionMessage" = true;
        "explorer.confirmDragAndDrop" = true;
        "editor.fontLigatures" = true;
        "editor.minimap.enabled" = true;
        "workbench.startupEditor" = "none";

        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.formatOnPaste" = true;

        "workbench.layoutControl.type" = "menu";
        "workbench.editor.limit.enabled" = true;
        "workbench.editor.limit.value" = 10;
        "workbench.editor.limit.perEditorGroup" = true;
        "workbench.editor.showTabs" = "multiple";
        "files.autoSave" = "onWindowChange";
        "explorer.openEditors.visible" = 0;
        "breadcrumbs.enabled" = false;
        "editor.renderControlCharacters" = false;
        "workbench.activityBar.location" = "default";
        "workbench.statusBar.visible" = false;
        "editor.scrollbar.verticalScrollbarSize" = 4;
        "editor.scrollbar.horizontalScrollbarSize" = 4;
        "editor.scrollbar.vertical" = "auto";
        "editor.scrollbar.horizontal" = "auto";
        "workbench.layoutControl.enabled" = false;

        "editor.mouseWheelZoom" = true;

        "C_Cpp.autocompleteAddParentheses" = true;
        "C_Cpp.formatting" = "clangFormat";
        "C_Cpp.intelliSenseCacheSize" = 2048;
        "C_Cpp.intelliSenseMemoryLimit" = 2048;
        "C_Cpp.default.browse.path" = [
          ''''${workspaceFolder}/**''
        ];
        "C_Cpp.default.cStandard" = "gnu99";
        "C_Cpp.inlayHints.parameterNames.hideLeadingUnderscores" = false;
        "C_Cpp.intelliSenseUpdateDelay" = 500;
        "C_Cpp.workspaceParsingPriority" = "medium";
        "C_Cpp.clang_format_sortIncludes" = true;
        "C_Cpp.doxygen.generatedStyle" = "/**";
      };
      # Keybindings
      keybindings = [
        {
          key = "ctrl+q";
          command = "editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+s";
          command = "workbench.action.files.saveFiles";
        }
      ];
    };
  };
}
