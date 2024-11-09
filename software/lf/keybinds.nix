{
  pkgs,
  user,
  ...
}: {
  user.manage.programs.lf = {
    # % To stay on lf (create a modal)
    # $ To temporarily go back to terminal
    commands = {
      ## Open with
      editor-open = ''$$EDITOR $f'';
      vlc-open = "%vlc .";
      thunar-open = "%thunar";

      # -- Utilities
      drag-file = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"''; # TODO Replace with ripdrag
      # Convert a .mp4 or H.264 file to .mov, useful to edit videos in davinci!
      convert-to-mov-file = ''%${pkgs.ffmpeg}/bin/ffmpeg -i "$fx" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$fx".mov'';

      # Create new folder
      create-folder = ''
        %{{
          echo -n " Enter folder name: "
          read foldername
          if [ -n "$foldername" ]; then
            mkdir "$foldername"
          else
            echo "Folder name cannot be empty."
          fi
        }}
      '';

      # Use unar and delete the file
      descompress-file = ''
        %{{
          ${pkgs.unar}/bin/unar "$fx"
          rm "$fx"
        }}
      '';

      # Merge videos into one, using tmp files and converting them to .ts, at the end delete all tmp files
      combine-videos = ''
        ''${{
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

      # -- Trash Utilities
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
          # Show the selected files and ask for confirmation
          echo -n "Are you sure you want to delete the selected files? y/n: "
          read selection

          # Delete the selected files if the user confirms
          if [ "$selection" == "y" ] || [ "$selection" == "Y" ]; then
            rm -rf ${user.home}/.local/share/Trash/files
            rm -rf ${user.home}/.local/share/Trash/info

            mkdir -p ${user.home}/.local/share/Trash/files ${user.home}/.local/share/Trash/info

            ${pkgs.libnotify}/bin/notify-send "Trash cleared successfully"
          else
            ${pkgs.libnotify}/bin/notify-send "Operation cancelled"
          fi
        }}
      '';

      # -- Overwriting default commands
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

      open = ''
        &{{
          file_mime_type=$(${pkgs.file}/bin/file -Lb --mime-type -- "$fx")
          case "$file_mime_type" in
            text/*)
              lf -remote "send $id \$$EDITOR \$fx"
              exit 0
            ;;
            video/*)
              ${pkgs.mpv}/bin/mpv "$fx"
              exit 0
            ;;
            image/*)
              ${pkgs.imv}/bin/imv "$fx"
              exit 0
            ;;
            *)
              ${pkgs.xdg_utils}/bin/xdg-open "$fx"
              echo "$file_mime_type"
              exit 0
            ;;
          esac
        }}
      '';

      # Instead of just renaming one file, rename all stored in $fx, at the end toggle and select the renamed files
      rename = ''
        %{{
          # Counter variable
          counter=0

          # Ask the user for input
          echo -n "Rename: "
          read new_name

          renamed_files=() # Array to store new paths

          # Loop through each file in fx
          while IFS= read -r file; do
            # Extract the directory, extension, and set current counter
            dir=$(dirname "$file")
            ext=$(basename "$file" | awk -F. '{print $NF}')
            current_counter=$counter

             # Check if the file is a directory
            if [[ -d "$file" ]]; then
              new_path="''${dir}/''${new_name}"  # Rename folder without a counter
            else
              # Skip appending 0 for the first file
              if [[ $current_counter -eq 0 ]]; then
                new_path="''${dir}/''${new_name}.''${ext}"
              else
                new_path="''${dir}/''${new_name}_''${current_counter}.''${ext}"
              fi
            fi

            # Ensure unique name by incrementing until no file exists
            while [[ -e "$new_path" ]]; do
              current_counter=$((current_counter + 1))
              if [[ -d "$file" ]]; then
                new_path="''${dir}/''${new_name}_''${current_counter}"  # For folder
              else
                new_path="''${dir}/''${new_name}_''${current_counter}.''${ext}"
              fi
            done

            # Store the new path in the array
            renamed_files+=("$new_path")

            # Rename the file
            mv "$file" "$new_path"

            # Increment the main counter
            counter=$((counter + 1))
          done <<< "$fx"

          # Unselect any previous file
          lf -remote "send $id unselect"

          # Keep the new files toggled only if there are multiple renamed files
          if [ ''${#renamed_files[@]} -gt 1 ]; then
            for path in "''${renamed_files[@]}"; do
              lf -remote "send $id toggle $path"
            done
          fi

          # And select the first from the list
          lf -remote "send $id select ''${renamed_files[0]}"
        }}
      '';
    };

    keybindings = {
      # keys
      r = "rename";
      dd = "drag-file";
      dm = "convert-to-mov-file";
      df = "descompress-file";
      dv = "combine-videos";
      "<esc>" = "quit";
      ## open with
      ov = "vlc-open";
      ot = "thunar-open";

      # control + key
      "<c-c>" = "copy";
      "<c-x>" = "cut";
      "<c-v>" = "paste";
      "<c-r>" = "reload";
      "<c-u>" = "unselect";
      "<c-d>" = "create-folder"; # Do the custom mkdir command

      # delete keys
      "<delete><enter>" = "delete-trash";
      "<delete><delete>" = "restore-trash";
      "<delete><backspace2>" = "empty-trash";

      # Unbind keys
      c = null;
      d = null;
      e = null;
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
      q = null; # Default: quit
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
  };
}
