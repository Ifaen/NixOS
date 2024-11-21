{pkgs, ...}: let
  commands = ''
    wezterm.on("update-status", function(window, pane)
      local process_name = pane:get_foreground_process_name()
      -- Prevent the modified keybindings to overwrite the other software keybindings
      if process_name == "${pkgs.lf}/bin/lf" then
        window:set_config_overrides({keys = default_keybindings})
      else
        window:set_config_overrides({keys = modified_keybindings})
      end
    end)
  '';

  modified-keybindings = ''
    local modified_keybindings = {
      -- Bind control+c to copy
      {
        key="c",
        mods="CTRL",
        action=wezterm.action.CopyTo 'Clipboard',
      },
      -- Bind control+v to paste # HACK because PasteFrom in Wayland doesn't seem to work, obtained from: https://github.com/wez/wezterm/issues/3968
      {
        key="v",
        mods="CTRL",
        action=wezterm.action_callback(function(window, pane)
          local success, stdout = wezterm.run_child_process({"${pkgs.wl-clipboard-rs}/bin/wl-paste", "--no-newline"})
          if success then
            pane:paste(stdout)
          end
        end),
      },
      -- Make Escape to cancel current process
      {
        key='Escape',
        action=wezterm.action.SendString '\x03'
      },
      -- Disable default copy
      {
        key="c",
        mods="CTRL|SHIFT",
        action=wezterm.action.Nop,
      },
      -- Disable default paste
      {
        key="v",
        mods="CTRL|SHIFT",
        action=wezterm.action.Nop,
      },
    }
  '';

  # Restore the default keybindings while inside other TUI's
  default-keybindings = ''
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
  '';
in {
  user.manage = {
    programs.wezterm.extraConfig = ''
      ${modified-keybindings}

      ${default-keybindings}

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
