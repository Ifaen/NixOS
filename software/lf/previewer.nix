{pkgs, ...}: {
  user.manage.programs.lf.extraConfig = ''
    set previewer ${pkgs.writeShellScript "lf-previewer.sh" ''
      function createPreview () {
        ${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
      }

      cache_dir="/tmp/lf"
      mkdir -p "$cache_dir"

      # Generate a unique cached filename using parent directory and basename
      parent_dir=$(basename "$(dirname "$1")")
      file_name=$(basename "$1")
      cached_file="$cache_dir/''${parent_dir}-''${file_name}.cache"

      path=""

      case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$1")" in
        application/pdf)
          path="$cached_file.jpg"
          if [ ! -f "$path" ]; then
            ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 -singlefile -jpeg "$1" "''${cached_file%.*}"
          fi
        ;;
        video/*)
          path="$cached_file.png"
          if [ ! -f "$path" ]; then
            ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$1" -o "$path" -s 0
          fi
        ;;
        image/svg+xml)
          path="$cached_file.png"
          if [ ! -f "$path" ]; then
            ${pkgs.librsvg}/bin/rsvg-convert -o "$path" "$1"
          fi
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
    ''}
  '';
}
