{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.wezterm.extraConfig = ''
    local modified_keybindings = {
      -- Change Control+C to copy
      {
        key="c",
        mods="CTRL",
        action=wezterm.action.CopyTo 'Clipboard',
      },
      -- Disable Control+Shift+C to copy
      {
        key="C",
        mods="CTRL|SHIFT",
        action=wezterm.action.Nop,
      },
      -- Change Control+V to paste
      {
        key="v",
        mods="CTRL",
        action=wezterm.action.PasteFrom 'Clipboard',
      },
      -- Disable Control+Shift+V
      {
        key="V",
        mods="CTRL|SHIFT",
        action=wezterm.action.Nop,
      },
      -- Make Escape to cancel current process
      {
        key='Escape',
        action=wezterm.action.SendString '\x03'
      },
    }

    -- Allow the software to decide what the keybinding does
    local default_keybindings = {
      {
        key="c",
        mods="CTRL",
        action=wezterm.action.SendKey { key = 'c', mods = 'CTRL' },
      },
      {
        key="C",
        mods="CTRL|SHIFT",
        action=wezterm.action.SendKey { key = 'c', mods = 'CTRL|SHIFT' },
      },
      {
        key="v",
        mods="CTRL",
        action=wezterm.action.SendKey { key = 'v', mods = 'CTRL' },
      },
      {
        key="V",
        mods="CTRL|SHIFT",
        action=wezterm.action.SendKey { key = 'V', mods = 'CTRL|SHIFT' },
      },
      {
        key='Escape',
        action=wezterm.action.SendKey { key = 'Escape' },
      },
    }

    wezterm.on("update-status", function(window, pane)
      local title = pane:get_title()

      -- Prevent the modified keybindings to overwritte the other software keybindings
      if title == "lf" then
        window:set_config_overrides({keys = default_keybindings})
      else
        window:set_config_overrides({keys = modified_keybindings})
      end
    end)

    config.keys = modified_keybindings

    return config
  '';
}
