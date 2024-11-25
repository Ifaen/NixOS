{pkgs, ...}: let
  # Keybinds that should always be active
  general-keybindings = ''
    { key='t', mods='CTRL', action=wezterm.action.SpawnTab 'CurrentPaneDomain' }, -- New tab
    { key='w', mods='CTRL', action=wezterm.action.CloseCurrentTab { confirm = true } }, -- Close tab

    -- Disable defaults
    { key="C", mods="CTRL|SHIFT", action=wezterm.action.DisableDefaultAssignment },
    { key="V", mods="CTRL|SHIFT", action=wezterm.action.DisableDefaultAssignment },
    { key='t', mods='SUPER', action=wezterm.action.DisableDefaultAssignment },
    { key='T', mods='CTRL|SHIFT', action=wezterm.action.DisableDefaultAssignment },
    { key="V", mods="CTRL|SHIFT", action=wezterm.action.DisableDefaultAssignment },
    { key='W', mods='CTRL|SHIFT', action=wezterm.action.DisableDefaultAssignment },

    -- Disable key press
    { key="1", mods="SUPER", action=wezterm.action.Nop },
    { key="2", mods="SUPER", action=wezterm.action.Nop },
    { key="3", mods="SUPER", action=wezterm.action.Nop },
    { key="4", mods="SUPER", action=wezterm.action.Nop },
    { key="5", mods="SUPER", action=wezterm.action.Nop },
    { key="6", mods="SUPER", action=wezterm.action.Nop },
    { key="7", mods="SUPER", action=wezterm.action.Nop },
    { key="8", mods="SUPER", action=wezterm.action.Nop },
    { key="9", mods="SUPER", action=wezterm.action.Nop },
    { key="0", mods="SUPER", action=wezterm.action.Nop },
  '';

  # Modified keybinds
  modified-keybindings = ''
    { key='c', mods='CTRL', action=wezterm.action.CopyTo 'Clipboard' }, -- Copy
    {
      key='v', mods='CTRL', -- Paste
      -- # HACK because PasteFrom in Wayland doesn't seem to work, obtained from: https://github.com/wez/wezterm/issues/3968
      action=wezterm.action_callback(function(window, pane)
        local success, stdout = wezterm.run_child_process({"${pkgs.wl-clipboard-rs}/bin/wl-paste", "--no-newline"})
        if success then
          pane:paste(stdout)
        end
      end),
    },
    { key='Escape', action=wezterm.action.SendString '\x03' }, -- Make Escape to cancel current process
  '';

  commands = ''
    wezterm.on("update-status", function(window, pane)
      local tty = pane:get_tty_name()

      local _, process_name, _ = wezterm.run_child_process({
        "${pkgs.bash}/bin/bash", "-c", "ps -t " .. tty .. " | grep '[l]f' | awk '{print $4}'"
      })

      if process_name == "lf\n" then
        window:set_config_overrides({keys = {${general-keybindings}}})
      else
        window:set_config_overrides({keys = {${general-keybindings}${modified-keybindings}}})
      end
    end)
  '';
in {
  user.manage = {
    programs.wezterm.extraConfig = ''
      ${commands}

      return config
    '';

    services.xremap.config.keymap = [
      {
        name = "workspace";

        remap = {
          super-space.launch = ["hyprctl" "dispatch" "workspace" "11"];
          super-shift-space.launch = ["hyprctl" "dispatch" "movetoworkspace" "11"];
        };
      }
    ];
  };
}
