{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.lf = {
      enable = true;

      settings = {
        icons = true; # Enable icons
        ignorecase = true; # To find files ignoring casing
        drawbox = true; # Borders around the columns
        mouse = true; # Enable mouse bindings
        # To preview images using Sixel with Chafa
        preview = true;
        sixel = true;
      };

      # % To stay on lf
      # $ To temporarily go back to terminal
      commands = {
        dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"''; # TODO Replace with ripdrag
        editor-open = ''$$EDITOR $f'';
        # Create new folder
        create-folder = ''
          %{{
            echo -n "Enter folder name: "
            read foldername
            if [ -n "$foldername" ]; then
              mkdir "$foldername"
            else
              echo "Folder name cannot be empty."
            fi
          }}
        '';
        # When opening a file, hide the preview column
        on-redraw = ''
          %{{
            if [ $lf_width -le 110 ]; then
              lf -remote "send $id :set preview false; set ratios 2:5"
            else
              lf -remote "send $id :set preview true; set ratios 1:2:3"
            fi
          }}
        '';
      };

      keybindings = {
        # keys
        r = "rename";
        "<delete>" = "delete";
        "<esc>" = "quit";
        # control + key
        "<c-c>" = "copy";
        "<c-x>" = "cut";
        "<c-v>" = "paste";
        "<c-r>" = "reload";
        "<c-u>" = "unselect";
        "<c-d>" = "create-folder"; # Do the custom mkdir command
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
        q = null;
        u = null;
        v = null;
        y = null;
        "<c-b>" = null;
        "<c-e>" = null;
        "<c-f>" = null;
        "<c-j>" = null;
        "<c-y>" = null;
        "'['" = null;
        "']'" = null;
        "':'" = null;
        "';'" = null;
        "','" = null;
      };

      extraConfig = ''
        set previewer ${
          pkgs.writeShellScript "lf-previewer.sh" ''
            function createPreview (
              ${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
            )

            path=""

            case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$1")" in
              application/pdf)
                path="/tmp/lf_preview_image" # pdftoppm adds the .jpg at the end anyway (like example.jpg.jpg)
                ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 -singlefile -jpeg "$1" "$path"
                path="/tmp/lf_preview_image.jpg" # so rewrite string
                break
                ;;
              video/*)
                path="/tmp/lf_preview_image.png"
                ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$1" -o "$path" -s 0
                break
              ;;
              image/svg+xml)
                path="/tmp/lf_preview_image.png"
                ${pkgs.librsvg}/bin/rsvg-convert -o "$path" "$1"
                break
              ;;
              image/*)
                createPreview "$1" "$2" "$3"
                exit
              ;;
              *)
                ${pkgs.pistol}/bin/pistol "$1"
                exit
              ;;
            esac

            createPreview "$path" "$2" "$3"
            rm "$path"
          ''
        }
      '';
    };

    xdg.configFile."lf/icons".source = ../../shared/styles/lf-icons;
  };
}
