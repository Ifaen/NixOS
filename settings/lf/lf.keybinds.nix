{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.lf = {
    # % To stay on lf
    # $ To temporarily go back to terminal
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"''; # TODO Replace with ripdrag
      editor-open = ''$$EDITOR $f'';

      # Convert a .mp4 or H.264 file to .mov
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
      # FIXME Empty all files in the trash. Currently not working as it should
      empty-trash = ''
        ''${{
          # Define the Trash folders
          trash_info="${user.home}/.local/share/Trash/info"

          # Show the contents of the Trash folder using fzf and capture the user's selection
          selected_files=$(find ${user.home}/.local/share/Trash/files -type f | fzf --preview 'cat {}' --preview-window=right:60% --multi)

          # If no files are selected, exit the script
          if [ -z "$selected_files" ]; then
            echo "No files selected. Exiting."
            exit 0
          fi

          # Show the selected files and ask for confirmation
          echo "Selected files:"
          echo "$selected_files"
          echo -n "Are you sure you want to delete the selected files? y/n: "
          read selection

          # Delete the selected files if the user confirms
          if [ "$selection" == "y" ] || [ "$selection" == "Y" ]; then
            echo "$selected_files"
            echo "Selected files deleted."
          else
            echo "Operation cancelled."
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
    };

    keybindings = {
      # keys
      r = "rename";
      dd = "dragon-out";
      em = "convert-to-mov-file";
      "<esc>" = "quit";

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
