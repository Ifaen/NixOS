{
  pkgs,
  user,
  ...
}: let
  open-rofi = "${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-categories X-Rofi";

  workspace-change = "${pkgs.writeShellScript "workspace-change" ''
    # Kill every instance, in case there was one
    pkill rofi

    # Change to provided workspace
    hyprctl dispatch workspace $1

    # Check if workspace is empty
    is_empty=$(hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq '.windows')

    # If empty, open program
    if [ $is_empty == 0 ]; then
      hyprctl dispatch exec "${open-rofi}"
    fi
  ''}";
in {
  user-manage.hyprland = {
    bind = [
      "SUPER, Q, killactive" # Kill active Window
      #"SUPER SHIFT, Q, killwindow" # Enter kill selection mode

      "SUPER, W, exec, pkill rofi || ${open-rofi}"

      # -- Workspaces
      "SUPER, LEFT, workspace, e-1"
      "SUPER, RIGHT, workspace, e+1"

      "SUPER, 1, exec, ${workspace-change} 1"
      "SUPER, 2, exec, ${workspace-change} 2"
      "SUPER, 3, exec, ${workspace-change} 3"
      "SUPER, 4, exec, ${workspace-change} 4"
      "SUPER, 5, exec, ${workspace-change} 5"
      "SUPER, 6, exec, ${workspace-change} 6"
      "SUPER, 7, exec, ${workspace-change} 7"
      "SUPER, 8, exec, ${workspace-change} 8"
      "SUPER, 9, exec, ${workspace-change} 9"
      "SUPER, 0, exec, ${workspace-change} 10"

      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow" # SUPER + LMB
      "SUPER, mouse:273, resizewindow" # SUPER + RMB
    ];

    input = {
      kb_layout = user.language; # Keyboard layout to be directed to user language
      kb_options = "compose:caps"; # Remap Caps-Lock key to be Compose Key
    };
  };
}
