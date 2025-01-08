{
  pkgs,
  user,
  ...
}: {
  user-manage.programs.lf = {
    # % To stay on lf (create a modal)
    # & To stay on lf but continue doing other tasks
    # $ To temporarily go back to terminal
    commands = {
      /*
      -- Open with
      */
      vlc-open = "&vlc $fx";
      thunar-open = "%thunar";

      /*
      -- Utilities
      */
      # Change the ownership of folders and files for the user
      change-owner = ''
        ''${{
          while IFS= read -r path; do
            if [ -d "$path" ] || [ -f "$path" ]; then
              sudo chown ${user.name}:users "$path" -R
            else
              ${pkgs.libnotify}/bin/notify-send "Error:" "$path should not be changed its ownership."
            fi
          done <<< "$fx"

          lf -remote "send $id select $f"
        }}
      '';

      # When moving things, names can change or repeat, so clear previewer cache
      clear-previewer = ''%rm -f /tmp/lf/*; ${pkgs.libnotify}/bin/notify-send "Previewer cache cleared" -t 2500'';

      # Convert a .mp4 or H.264 file to .mov, useful to edit videos in davinci!
      convert-to-mov-file = ''%${pkgs.ffmpeg}/bin/ffmpeg -i "$fx" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$fx".mov'';

      # Create new folder
      create-folder = ''
        %{{
          echo -n " Enter folder name: "
          read foldername
          if [ -n "$foldername" ]; then
            mkdir "$foldername"
            lf -remote "send $id select $foldername"
          else
            ${pkgs.libnotify}/bin/notify-send "Folder name cannot be empty." -t 2000
            lf -remote "send $id select $f"
          fi
        }}
      '';

      # Drag files
      drag-file = "%${pkgs.ripdrag}/bin/ripdrag $fx";

      # Use unar and delete the file
      descompress-file = let
        accepted-files = "zip|gzip|bzip2|xz|rar|7z|lzh|tar";
      in ''
        %{{
          if [ "$(echo "$fx" | wc -l)" -gt 1 ]; then
            foldername="dir_$RANDOM"

            while IFS= read -r path; do
              if ${pkgs.file}/bin/file "$path" | grep -qE "${accepted-files}"; then
                name=$(basename "$path" | cut -d. -f1)

                if [ -e "$foldername/$name" ]; then
                  name="$name$RANDOM"
                fi

                ${pkgs.unar}/bin/unar "$path" -D -o "$foldername/$name"

                rm "$path"
              fi
            done <<< "$fx"

            if [ -e "$foldername" ]; then
              cd "$foldername"
            fi
          else
            if ${pkgs.file}/bin/file "$f" | grep -qE "${accepted-files}"; then
              name=$(basename "$f" | cut -d. -f1)

              if [ -e "$name" ]; then
                name="$name$RANDOM"
              fi

              ${pkgs.unar}/bin/unar "$f" -D -o "$name"

              rm "$f"

              cd "$name"
            fi
          fi
        }}
      '';

      # Merge videos into one, using tmp files and converting them to .ts, at the end delete all tmp files
      combine-videos = ''
        %{{
          base_output_file="_$(basename "$PWD").mp4"
          output_file="$base_output_file"

          count=1
          while [[ -e "$output_file" ]]; do
            output_file="_$(basename "$PWD")_$count.mp4"
            count=$((count + 1))
          done

          video_list=$(mktemp)
          audio_list=$(mktemp)
          temp_files=("$video_list" "$audio_list")

          for file in $fx; do
            temp_video=$(mktemp --suffix=.ts)
            temp_audio=$(mktemp --suffix=.ts)

            temp_files+=("$temp_video" "$temp_audio")

            ${pkgs.ffmpeg}/bin/ffmpeg -y -i "$file" -c:v copy -an -bsf:v h264_mp4toannexb -f mpegts "$temp_video"
            echo "file '$temp_video'" >> "$video_list"

            audio_streams=$( ${pkgs.ffmpeg}/bin/ffmpeg -i "$file" 2>&1 | grep -o 'Audio: .*' )
            if [[ -n "$audio_streams" ]]; then
              ${pkgs.ffmpeg}/bin/ffmpeg -y -i "$file" -c:a copy -vn -f mpegts "$temp_audio"
              echo "file '$temp_audio'" >> "$audio_list"
            fi
          done

          merged_video=$(mktemp --suffix=.ts)
          merged_audio=$(mktemp --suffix=.ts)
          temp_files+=("$merged_video" "$merged_audio")

          ${pkgs.ffmpeg}/bin/ffmpeg -y -f concat -safe 0 -i "$video_list" -c copy -bsf:v h264_mp4toannexb "$merged_video"

          if [[ -s "$audio_list" ]]; then
            ${pkgs.ffmpeg}/bin/ffmpeg -y -f concat -safe 0 -i "$audio_list" -c copy "$merged_audio"
            ${pkgs.ffmpeg}/bin/ffmpeg -i "$merged_video" -i "$merged_audio" -c:v copy -c:a copy -bsf:a aac_adtstoasc "$output_file"
          else
            ${pkgs.ffmpeg}/bin/ffmpeg -i "$merged_video" -c:v copy -bsf:a aac_adtstoasc "$output_file"
          fi

          lf -remote "send $id unselect"
          lf -remote "send $id select $output_file"

          for temp_file in "''${temp_files[@]}"; do
            rm -f "$temp_file"
          done
        }}
      '';

      # Select all files and folders in the current directory
      select-all = ":unselect; invert";

      /*
      -- Trash Utilities
      */
      # Delete to the trash all selected files
      delete-trash = ''
        %{{
          while IFS= read -r file; do
            ${pkgs.trashy}/bin/trash put "$file"
          done <<< "$fx"
        }}
      '';
      # Using fzf to restore selected items from trash by id in the list
      restore-trash = ''
        ''${{
          selected_files=$(${pkgs.trashy}/bin/trash list | ${pkgs.fzf}/bin/fzf --multi | awk '{print $1}')

          while IFS= read -r file; do
            ${pkgs.trashy}/bin/trash restore -f -r "$file"
          done <<< "$selected_files"
        }}
      '';
      # Clear Trash files and info folders.
      empty-trash = ''
        %{{
          echo -n "Are you sure you want to delete the selected files? y/n: "
          read selection

          # Delete the selected files if the user confirms
          if [ "$selection" == "y" ] || [ "$selection" == "Y" ]; then
            rm -rf ${user.dir.data}/Trash/files/*
            rm -rf ${user.dir.data}/Trash/info/*

            ${pkgs.libnotify}/bin/notify-send "Trash cleared successfully"

          else
            ${pkgs.libnotify}/bin/notify-send "Operation cancelled"
          fi

          lf -remote "send $id select $f"
        }}
      '';

      /*
      -- Overwriting default commands
      */
      # When opening a file, hide the preview column
      on-redraw = ''
        &{{
          if [ $lf_width -le 110 ]; then
            lf -remote "send $id :set preview false; set ratios 2:5"
          else
            lf -remote "send $id :set preview true; set ratios 1:2:3"
          fi
        }}
      '';

      open = ''
        &{{
          while IFS= read -r path; do
            case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$path")" in
              text/*)
                ${pkgs.vscode}/bin/code "$path" &
              ;;
              video/*)
                ${pkgs.mpv}/bin/mpv "$path" &
              ;;
              image/*)
                ${pkgs.imv}/bin/imv "$path" &
              ;;
              *)
                ${pkgs.xdg-utils}/bin/xdg-open "$path" &
              ;;
            esac
          done <<< "$fx"
        }}
      '';

      # Added functionality to rename multiple files or just one
      rename = let
        rename-one = ''
          # If string is empty
          if [ -z "$new_name" ]; then
            ${pkgs.libnotify}/bin/notify-send "Error:" "New name is empty. Rename operation aborted."
            lf -remote "send $id select $f"
          # If string is the same
          elif [ -e "$new_name" ]; then
            ${pkgs.libnotify}/bin/notify-send "Error:" "The file '$new_name' already exists. Choose a different name."
            lf -remote "send $id select $f"
          # Announce the new name
          else
            ${pkgs.libnotify}/bin/notify-send "Renamed '$(basename $f)' to '$new_name'."
            mv "$f" "$new_name"
            lf -remote "send $id select '$new_name'"
          fi
        '';

        # Rename multiples files, ignores folders
        rename-multiple = ''
          # For every path in $fx
          while IFS= read -r path; do
            # If path is a file
            if [[ -f "$path" ]]; then
              counter=1
              # Extract the extension from the original path
              ext=$(basename "$path" | awk -F. '{print "." $NF}')

              # Merge the new path using the new name and original extension
              new_path="$new_name$ext"

              # Check if new path exists, if so, add a number
              while [[ -e "$new_path" ]]; do
                new_path="''${new_name}_$counter$ext"

                counter=$((counter + 1))
              done

              # Rename the previous path with the new path
              mv "$path" "$new_path"

              # Toggle selection
              lf -remote "send $id toggle $new_path"
            fi
          done <<< "$fx"

          ${pkgs.libnotify}/bin/notify-send "Renamed files with the \"$new_name\" prefix"

          lf -remote "send $id select $new_path"
        '';
      in ''
        %{{
          # Ask the user for input
          echo -n "Rename: "

          # Count the amount of files to be renamed
          if [ "$(echo "$fx" | wc -l)" -gt 1 ]; then
            lf -remote "send $id push $(basename "$(dirname "$f")")"
            read new_name

            ${rename-multiple}
          else
            lf -remote "send $id push $(basename "$f" | sed 's/ /<space>/g')"
            read new_name

            ${rename-one}
          fi
        }}
      '';

      /*
      -- Renaming default commands
      */
      sort-naturally = ''%{{lf -remote "send $id :set sortby natural; set info"}}'';
      sort-by-size = ''%{{lf -remote "send $id :set sortby size; set info size"}}'';
      sort-by-time = ''%{{lf -remote "send $id :set sortby time; set info time"}}'';
      sort-by-extension = ''%{{lf -remote "send $id :set sortby ext; set info"}}'';

      show-info = ''%{{lf -remote "send $id :set size:time"}}'';
      show-hidden = ''%{{lf -remote "send $id :set hidden!"}}'';
      show-reverse = ''%{{lf -remote "send $id :set reverse!"}}'';
    };

    keybindings = {
      co = "change-owner";
      dd = "drag-file";
      dm = "convert-to-mov-file";
      df = "descompress-file";
      dv = "combine-videos";
      ov = "vlc-open";
      "<c-a>" = "select-all";
      "<c-d>" = "create-folder";

      # -- Trash utilities
      "<delete><enter>" = "delete-trash";
      "<delete>r" = "restore-trash";
      "<delete>a" = "empty-trash";
      "<delete>p" = "clear-previewer";

      # -- Overwriting default commands
      r = "rename";

      # -- Renaming default commands
      sn = "sort-naturally";
      ss = "sort-by-size";
      st = "sort-by-time";
      se = "sort-by-extension";

      zh = "show-hidden";
      zr = "show-reverse";

      # -- Remapping default commands
      i = "thunar-open"; # default: $$PAGER "$f"
      zi = "show-info";
      "<c-c>" = "copy";
      "<c-x>" = "cut";
      "<c-v>" = "paste";
      "<c-u>" = "unselect";
      "<esc>" = "quit";

      # -- Unbind keys (The comments indicates their default usage)
      c = null; # clear
      d = null; # cut
      e = null; # $$EDITOR "$f"
      f = null; # find
      F = null; # find-back
      gg = null; # top
      G = null; # bottom
      h = null; # updir
      H = null; # High
      j = null; # down
      k = null; # up
      l = null; # open
      L = null; # Low
      m = null; # mark-save
      M = null; # middle
      p = null; # paste
      q = null; # quit
      sa = null; # sort by atime
      sc = null; # sort by ctime
      t = null; # tag-toggle
      u = null; # unselect
      v = null; # invert
      w = null; # $$SHELL
      y = null; # copy
      zn = null; # :set info
      zs = null; # :set info size
      zt = null; # :set info time
      za = null; # :set info size:time
      "<c-b>" = null; # page-up
      "<c-e>" = null; # scroll-down
      "<c-f>" = null; # page-down
      "<c-j>" = null; # cmd-enter
      "<c-y>" = null; # scroll-up
      "<c-l>" = null; # redraw
      "<f-1>" = null; # $$lf -doc | $PAGER
      "'['" = null; # jump-prev
      "']'" = null; # jump-next
      "':'" = null; # read
      "';'" = null; # find-next
      "','" = null; # find-prev
      "'?'" = null; # search-back
      "'\"'" = null; # mark-remove
      "\"'\"" = null; # mark-load
    };
  };
}
