{ pkgs, ... }:

{
  imports = [
    ./polybar.nix
    ./feh.nix
    ./picom.nix
  ];

  services.xserver.windowManager.i3 = {
    enable = true;

    extraConfig = "
set $mod Mod4

font pango:Meslo LGM Nerd Font 10

# Screens settings
exec --no-startup-id xrandr --output DP-2 --mode 1920x1080 --rate 165 --primary --output HDMI-2 --rotate left --left-of DP-2

# Polybar
exec_always --no-startup-id polybar-msg cmd quit
exec_always --no-startup-id polybar

# Wallpaper
exec_always feh --bg-scale ~/Pictures/nix-black-4k.png

# Start XDG autostart .desktop files using dex. See also
# https://wiki.archlinux.org/index.php/XDG_Autostart
# exec --no-startup-id dex --autostart --environment i3

# The combination of xss-lock, nm-applet and pactl is a popular choice, so
# they are included here as an example. Modify as you see fit.

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
# exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

# NetworkManager is the most popular way to manage wireless networks on Linux,
# and nm-applet is a desktop environment-independent system tray GUI for it.
# exec --no-startup-id nm-applet

# Use pactl to adjust volume in PulseAudio.
# set $refresh_i3status killall -SIGUSR1 i3status
# bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
# bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
# bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
# bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# move tiling windows via drag & drop by left-clicking into the title bar,
# or left-clicking anywhere into the window while holding the floating modifier.
# tiling_drag modifier titlebar

# start a terminal
bindsym $mod+Return exec ghostty

# kill focused window
bindsym $mod+q kill

# start rofi (a program launcher)
bindsym $mod+d exec --no-startup-id rofi -show drun
bindsym $mod+Tab exec --no-startup-id rofi -show window

# Flameshot (screenshot)
bindsym $mod+Shift+s exec --no-startup-id flameshot gui
bindsym $mod+Shift+Ctrl+s exec --no-startup-id flameshot screen

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
# bindsym $mod+h split h

# split in vertical orientation
# bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+z layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# gaps
gaps inner 7px
gaps outer 2px

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 '1'
set $ws2 '2'
set $ws3 '3'
set $ws4 '4'
set $ws5 '5'
set $ws6 '6'
set $ws7 '7'
set $ws8 '8'
set $ws9 '9'
set $ws10 '10'

# switch workspace by scrolling
bindsym --whole-window $mod+button5 workspace next_on_output
bindsym --whole-window $mod+button4 workspace prev_on_output

# switch to workspace
bindsym $mod+ampersand workspace number $ws1
bindsym $mod+eacute workspace number $ws2
bindsym $mod+quotedbl workspace number $ws3
bindsym $mod+apostrophe workspace number $ws4
bindsym $mod+parenleft workspace number $ws5
bindsym $mod+minus workspace number $ws6
bindsym $mod+egrave workspace number $ws7
bindsym $mod+underscore workspace number $ws8
bindsym $mod+ccedilla workspace number $ws9
bindsym $mod+agrave workspace number $ws10

# move focused container to workspace
bindsym $mod+Shift+ampersand move container to workspace number $ws1
bindsym $mod+Shift+eacute move container to workspace number $ws2
bindsym $mod+Shift+quotedbl move container to workspace number $ws3
bindsym $mod+Shift+apostrophe move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+minus move container to workspace number $ws6
bindsym $mod+Shift+egrave move container to workspace number $ws7
bindsym $mod+Shift+underscore move container to workspace number $ws8
bindsym $mod+Shift+ccedilla move container to workspace number $ws9
bindsym $mod+Shift+agrave move container to workspace number $ws10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec 'i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit''

# resize window (you can also use the mouse for that)
mode 'resize' {
  # These bindings trigger as soon as you enter the resize mode

  # Pressing left will shrink the window’s width.
  # Pressing right will grow the window’s width.
  # Pressing up will shrink the window’s height.
  # Pressing down will grow the window’s height.
  bindsym l resize grow width 10 px or 10 ppt
  bindsym j resize grow height 10 px or 10 ppt
  bindsym k resize shrink height 10 px or 10 ppt
  bindsym h resize shrink width 10 px or 10 ppt

  # same bindings, but for the arrow keys
  bindsym Left resize shrink width 10 px or 10 ppt
  bindsym Down resize grow height 10 px or 10 ppt
  bindsym Up resize shrink height 10 px or 10 ppt
  bindsym Right resize grow width 10 px or 10 ppt

  # back to normal: Enter or Escape or $mod+r
  bindsym Return mode 'default'
  bindsym Escape mode 'default'
  bindsym $mod+r mode 'default'
}

bindsym $mod+r mode 'resize'


# window border
for_window [class='^.*'] border pixel 1
    ";

    extraPackages = with pkgs; [
      feh
    ];
  };
}
