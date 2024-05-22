{pkgs, ...}: {
  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"''; # TODO Replace with ripdrag
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };

    keybindings = {
      # key
      r = "rename";
      "<delete>" = "delete";
      # control + key
      "<c-c>" = "copy";
      "<c-x>" = "cut";
      "<c-v>" = "paste";
      "<c-r>" = "reload";
      "<c-u>" = "unselect";
      "<c-d>" = "mkdir";
      # Unbind keys
      c = null;
      d = null;
      f = null;
      F = null;
      gg = null;
      G = null;
      h = null;
      H = null;
      j = null;
      k = null;
      l = null;
      L = null;
      m = null;
      M = null;
      p = null;
      u = null;
      v = null;
      y = null;
      "<c-b>" = null;
      "<c-e>" = null;
      "<c-f>" = null;
      "<c-j>" = null;
      "<c-y>" = null;
      #"[" = "";
      #"]" = "";
      #":" = "";
      #";" = "";
      #"," = "";
      #"?" = "";
      #"'" = "";
      #"\"" = "";
    };

    settings = {
      preview = true;
      sixel = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = ''
      set previewer ${
        pkgs.writeShellScript "lf-previewer.sh" ''
          case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$1")" in
            image/*)
              ${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
              exit 1
              ;;
            *)
              cat "$1"
              ;;
          esac
        ''
      }
    '';
  };

  xdg.configFile."lf/icons".source = ../../shared/styles/lf-icons;
}
