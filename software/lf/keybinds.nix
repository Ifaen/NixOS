{
  unstable-pkgs,
  pkgs,
  user,
  ...
}: {
  user-manage.programs.lf = let
    accepted-files = "zip|gzip|bzip2|xz|rar|7z|lzh|tar";
    open = ''
      case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$f")" in
        text/* | inode/x-empty | application/json) windsurf "$f" & ;;
        video/*) mpv "$f" & ;;
        image/*) imv "$f" & ;;
        *) ${pkgs.xdg-utils}/bin/xdg-open "$f" & ;;
      esac'';
    delete = ''${pkgs.trashy}/bin/trash put "$f"'';
  in {
    # % To stay on lf (create a modal)
    # & To stay on lf but continue doing other tasks
    # $ To temporarily go back to terminal

    ## MARK: Open
    # Open current file
    commands.open = ''&{{${open}}}'';

    # Open the current viewed file, ignoring the other selected files
    commands.open-multiple = ''
      &{{
        while IFS= read -r f; do
          ${open}
        done <<< "$fx"
      }}'';
    keybindings."<a-right>" = "open-multiple";

    # Open VLC
    commands.vlc-open = "&${pkgs.vlc}/bin/vlc $fx";
    keybindings.ov = "vlc-open";

    # Open Thunar
    commands.thunar-open = "&thunar";
    keybindings.op = "thunar-open"; # default: $$PAGER "$f"

    # Open script
    commands.script-open = ''
      &{{
        filename=$(basename "$f")
        mime_type=$(${pkgs.file}/bin/file -Lb --mime-type "$f")

        if [ $mime_type = "text/x-shellscript" ]; then
          result=$(bash "$f")
          ${pkgs.libnotify}/bin/notify-send "Running $filename script" "Result: $result"
        else
          ${pkgs.libnotify}/bin/notify-send "Not a script"
        fi
      }}'';
    keybindings.os = "script-open";

    # MARK: Make
    # Make a new file
    commands.make-file = ''
      %{{
        echo -n " Enter file name: "
        read filename
        if [ -n "$filename" ]; then
          touch "$filename"
          lf -remote "send $id select $filename"
        else
          ${pkgs.libnotify}/bin/notify-send "File name cannot be empty." -t 2000
          lf -remote "send $id select $f"
        fi
      }}'';
    keybindings.mf = "make-file";

    # Make a new folder
    commands.make-folder = ''
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
      }}'';
    keybindings.md = "make-folder";

    # Make a symlink for each selected file
    commands.make-symlink = ''
      %{{
        while IFS= read -r path; do
          ln -s "$path" "$PWD/link_$(basename $(dirname "$path"))_$(basename "$path")"
        done <<< "$fx"

        lf -remote "send $id unselect"
      }}'';
    keybindings.ms = "make-symlink";

    # MARK: Modify
    # Modify the ownership of folders and files for the user. If empty, automatically use own username
    commands.modify-owner = ''
      ''${{
        echo -n " Enter user name (if empty, use ${user.name}): "
        read username

        while IFS= read -r path; do
          if [ -d "$path" ] || [ -f "$path" ]; then
            if [ -z "$username" ]; then
              username=${user.name}
            fi
            sudo chown -R "$username" "$path" 
          else
            ${pkgs.libnotify}/bin/notify-send "Error:" "$path should not be changed its ownership."
          fi
        done <<< "$fx"

        lf -remote "send $id select $f"
      }}'';
    keybindings."<a-m>o" = "modify-owner";

    # Modify the group of folders and files for the user. If empty, automatically use current group
    commands.modify-group = ''
      ''${{
        echo -n " Enter group name (if empty, use current group): "
        read groupname

        while IFS= read -r path; do
          if [ -d "$path" ] || [ -f "$path" ]; then
            if [ -z "$groupname" ]; then
              groupname=$(id -gn)
            fi
            sudo chgrp -R "$groupname" "$path"
          else
            ${pkgs.libnotify}/bin/notify-send "Error:" "$path should not be changed its group."
          fi
        done <<< "$fx"

        lf -remote "send $id select $f"
      }}'';
    keybindings."<a-m>g" = "modify-group";

    # Modify file to be executable
    commands.modify-executable = ''
      %{{
        if [ -f "$f" ]; then
          chmod +x "$f"
        fi
      }}'';
    keybindings."<a-m>e" = "modify-executable";

    # MARK: Sort
    # Sort files
    commands.sort-naturally = ''%{{lf -remote "send $id :set sortby natural; set info"}}'';
    keybindings.sn = "sort-naturally";

    # Sort files by its disk size
    commands.sort-by-size = ''%{{lf -remote "send $id :set sortby size; set info size"}}'';
    keybindings.ss = "sort-by-size";

    # Sort files by last time edited
    commands.sort-by-time = ''%{{lf -remote "send $id :set sortby time; set info time"}}'';
    keybindings.st = "sort-by-time";

    # Sort files by its extension
    commands.sort-by-extension = ''%{{lf -remote "send $id :set sortby ext; set info"}}'';
    keybindings.se = "sort-by-extension";

    # MARK: Show
    # Show information about files
    commands.show-info = ''%{{lf -remote "send $id :set size:time"}}'';
    keybindings.zi = "show-info";

    # Show hidden files
    commands.show-hidden = ''%{{lf -remote "send $id :set hidden!"}}'';
    keybindings.zh = "show-hidden";

    # Show reverse (Invert order of files)
    commands.show-reverse = ''%{{lf -remote "send $id :set reverse!"}}'';
    keybindings.zr = "show-reverse";

    # Delete to the trash the current file
    commands.delete-trash = ''&${delete}'';
    keybindings."<delete><enter>" = "delete-trash";

    # MARK: Trash
    # Delete multiple files
    commands.delete-multiple-trash = ''
      %{{
        while IFS= read -r f; do
          ${delete}
        done <<< "$fx"
      }}'';
    keybindings."<a-delete><enter>" = "delete-multiple-trash";

    # Using fzf to restore selected items from trash by id in the list
    commands.restore-trash = ''
      ''${{
        selected_files=$(${pkgs.trashy}/bin/trash list | ${pkgs.fzf}/bin/fzf --multi | awk '{print $1}')

        while IFS= read -r file; do
          ${pkgs.trashy}/bin/trash restore -f -r "$file"
        done <<< "$selected_files"
      }}'';
    keybindings."<delete>r" = "restore-trash";

    # Clear Trash files and info folders.
    commands.empty-trash = ''
      %{{
        echo -n "Are you sure you want to delete the selected files? y/n: "
        read selection

        # Delete the selected files if the user confirms
        if [ "$selection" == "y" ] || [ "$selection" == "Y" ]; then
          rm -rf ${user.data}/Trash/*

          ${pkgs.libnotify}/bin/notify-send "Trash cleared successfully"
        else
          ${pkgs.libnotify}/bin/notify-send "Operation cancelled"
        fi

        lf -remote "send $id select $f"
      }}'';
    keybindings."<delete>a" = "empty-trash";

    # MARK: Change
    # Rename current file
    commands.rename = ''
      %{{
        # Ask the user for input
        echo -n "Rename: "

        # Type the current name
        lf -remote "send $id push $(basename "$f" | sed 's/ /<space>/g')"

        # Store the new name
        read new_name

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
      }}'';
    keybindings.r = "rename";

    # Rename multiple files
    commands.rename-multiple = ''
      %{{
        echo -n "Rename: "

        lf -remote "send $id push $(basename "$(dirname "$f")")"
        read new_name

        # For every path in $fx
        while IFS= read -r path; do
          # If path is a file
          if [[ -f "$path" ]]; then
            counter=1

            # Extract the extension from the original path
            ext=$(basename "$path" | awk -F. '{print "." $NF}')

            # Merge the new path using the new name and original extension
            new_path="$new_name$ext"

            # Check if new path exists, if so, increment the counter
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
      }}'';
    keybindings."<a-r>" = "rename-multiple";

    # Change wallpaper with current file
    commands.change-wallpaper = ''
      %{{
        if [[ "$(${pkgs.file}/bin/file -Lb --mime-type -- "$f")" == image/* ]]; then
          ${pkgs.waypaper}/bin/waypaper --wallpaper $f
        else
          ${pkgs.libnotify}/bin/notify-send "Error:" "Not an image file"
        fi
      }}'';
    keybindings."<a-c>w" = "change-wallpaper";

    # MARK: Go to
    # Go to the top of the current directory
    keybindings."gt" = "top";

    # Go to the bottom of the current directory
    keybindings."gb" = "bottom";

    # Go to the home directory
    commands.go-to-home = "cd ~";
    keybindings."gh" = "go-to-home";

    # Go to the root directory
    commands.go-to-root = "cd /";
    keybindings."Gr" = "go-to-root";

    # Go to the documents directory
    commands.go-to-documents = "cd ${user.documents}";
    keybindings."Gd" = "go-to-documents";

    # Go to the downloads directory
    commands.go-to-downloads = "cd ${user.downloads}";
    keybindings."GD" = "go-to-downloads";

    # Go to the media directory
    commands.go-to-media = "cd ${user.media}";
    keybindings."Gm" = "go-to-media";

    # Go to the sync directory
    commands.go-to-sync = "cd ${user.sync}";
    keybindings."Gs" = "go-to-sync";

    # Go to the nixos flake directory
    commands.go-to-nixos = "cd ${user.flake}";
    keybindings."Gn" = "go-to-nixos";

    # Go to the nixos store directory
    commands.go-to-nixos-store = "cd /nix/store";
    keybindings."GN" = "go-to-nixos-store";

    # MARK: Utilities
    # Use unar to descompress files and delete the file
    commands.descompress-file = ''
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
      }}'';
    keybindings.Uf = "descompress-file";
    # Select all files and folders in the current directory
    commands.select-all = ":unselect; invert";
    keybindings.a = "select-all";

    # MARK: Mapping commands
    keybindings.c = "copy";
    keybindings.x = "cut";
    keybindings.v = "paste";
    keybindings.u = "unselect";
    keybindings.q = "quit";
    keybindings.f = "search";
    keybindings."<space>" = "toggle";
  };
}
