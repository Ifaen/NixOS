{
  pkgs,
  user,
  ...
}: {
  # Script adapted from: https://github.com/gokcehan/lf/wiki/Previews
  user-manage.programs.lf.extraConfig = let
    cache = "${user.cache}/thumbnails/lf";
    index = "${cache}/index.json";
  in ''
    set previewer ${pkgs.writeShellScript "lf-previewer.sh" ''
      draw() {
        kitten icat --stdin no --transfer-mode memory --place "''${w}x''${h}@''${x}x''${y}" "$1" </dev/null >/dev/tty
        exit 1
      }

      # Function adapted from: https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
      vidthumb() {
        if ! [ -f "$1" ]; then
          exit 1
        fi

        movie="$(realpath "$1")"

        mkdir -p "${cache}"

        if [ -f "${index}" ]; then
          thumbnail="$(${pkgs.jq}/bin/jq -r --arg movie "$movie" '.[$movie] // empty' "${index}")"

          if [[ -n "$thumbnail" && -f "${cache}/$thumbnail" ]]; then
            echo "${cache}/$thumbnail"
            exit 0
          fi
        fi

        thumbnail="$(uuidgen).jpg"

        if ! ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$movie" -o "${cache}/$thumbnail" -s 0 2>/dev/null; then
          exit 1
        fi

        if [[ ! -f "${index}" ]]; then
          echo "{}" > "${index}"
        fi

        json="$(${pkgs.jq}/bin/jq --arg movie "$movie" --arg thumb "$thumbnail" '. + {($movie): $thumb}' "${index}")"
        echo "$json" > "${index}"

        echo "${cache}/$thumbnail"
      }


      file="$1"
      w="$2"
      h="$3"
      x="$4"
      y="$5"

      case "$(${pkgs.file}/bin/file -Lb --mime-type "$file")" in
        image/*) draw "$file" ;;
        video/*) draw "$(vidthumb "$file")";;
        *) ${pkgs.pistol}/bin/pistol "$file";;
      esac
    ''}

    set cleaner ${pkgs.writeShellScript "lf-cleaner.sh" ''
      exec kitten icat --clear --stdin no --transfer-mode memory </dev/null >/dev/tty
    ''}
  '';
}
