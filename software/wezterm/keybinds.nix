{pkgs, ...}: let
  # Keybinds that should always be active
  general-keybindings = ''
    { key='t', mods='CTRL', action=wezterm.action.SpawnTab 'CurrentPaneDomain' }, -- New tab
    { key='w', mods='CTRL', action=wezterm.action.CloseCurrentTab { confirm = true } }, -- Close tab

    { key='V', mods='CTRL|SHIFT', action=wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- Split horizontal
    { key='B', mods='CTRL|SHIFT', action=wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } }, -- Split vertical
    { key='W', mods='CTRL|SHIFT', action=wezterm.action.CloseCurrentPane { confirm = true } }, -- Close pane

    { key='l', mods='CTRL|SHIFT', action=wezterm.action.AdjustPaneSize {"Right", 1} },
    { key='j', mods='CTRL|SHIFT', action=wezterm.action.AdjustPaneSize {"Left", 1} },
    { key='i', mods='CTRL|SHIFT', action=wezterm.action.AdjustPaneSize {"Up", 1} },
    { key='k', mods='CTRL|SHIFT', action=wezterm.action.AdjustPaneSize {"Down", 1} },

    { key='RightArrow', mods='CTRL|SHIFT', action=wezterm.action.ActivatePaneDirection 'Right' },
    { key='LeftArrow', mods='CTRL|SHIFT', action=wezterm.action.ActivatePaneDirection 'Left' },
    { key='UpArrow', mods='CTRL|SHIFT', action=wezterm.action.ActivatePaneDirection 'Up' },
    { key='DownArrow', mods='CTRL|SHIFT', action=wezterm.action.ActivatePaneDirection 'Down' },


    { key="1", mods="CTRL", action=wezterm.action.ActivateTab(0) },
    { key="2", mods="CTRL", action=wezterm.action.ActivateTab(1) },
    { key="3", mods="CTRL", action=wezterm.action.ActivateTab(2) },
    { key="4", mods="CTRL", action=wezterm.action.ActivateTab(3) },
    { key="5", mods="CTRL", action=wezterm.action.ActivateTab(4) },
    { key="6", mods="CTRL", action=wezterm.action.ActivateTab(5) },
    { key="7", mods="CTRL", action=wezterm.action.ActivateTab(6) },
    { key="8", mods="CTRL", action=wezterm.action.ActivateTab(7) },
    { key="9", mods="CTRL", action=wezterm.action.ActivateTab(8) },
    { key="0", mods="CTRL", action=wezterm.action.ActivateTab(-1) },
    { key="RightArrow", mods="CTRL", action=wezterm.action.ActivateTabRelative(1) },
    { key="LeftArrow", mods="CTRL", action=wezterm.action.ActivateTabRelative(-1) },
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
      config.disable_default_key_bindings = true

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
