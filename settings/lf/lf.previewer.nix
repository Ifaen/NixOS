{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.lf.extraConfig = ''
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
}
