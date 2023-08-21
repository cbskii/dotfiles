# NOTE: Refer to default config to see what has been modified.
# License moved to LICENSE file in same directory.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()
groups = [Group(i) for i in [ "  ", "  ", "  ", "  ", "  " ]]
catppuccin = {
    "rosewater": "#f5e0dc",
    "flamingo": "#f2cdcd",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "maroon": "#eba0ac",
    "peach": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "sapphire": "#74c7ec",
    "blue": "#89b4fa",
    "lavender": "#b4befe",
    "text": "#cdd6f4",
    "subtext1": "#bac2de",
    "subtext0": "#a6adc8",
    "overlay2": "#9399b2",
    "overlay1": "#7f849c",
    "overlay0": "#6c7086",
    "surface2": "#585b70",
    "surface1": "#45475a",
    "surface0": "#313244",
    "base": "#1e1e2e",
    "mantle": "#181825",
    "crust": "#11111b",
}

# Keybinds
keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),

    # Move between windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod], "n", lazy.layout.normalize()),

    # Toggle window focus
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.reload_config()),

    # Launchers
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "space", lazy.spawn("rofi -show drun")),

    # Volume control
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -10%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +10%")),
]

# Associate a number with each group allowing easy switching
for i, group in enumerate(groups):
    keys.extend(
        [
            # Switch to group
            Key([mod], str(i + 1),
                lazy.group[group.name].toscreen()),

            # Move focus to group and switch
            Key([mod, "shift"], str(i + 1),
                lazy.window.togroup(group.name, switch_group=True)),
        ]
    )

# Supported layouts and their configuration
layouts = [
    layout.MonadTall(
        margin = 10,
        border_width = 0,
    ),
]

# Default widget and extension settings
widget_defaults = dict(
    font="JetBrains-Mono",
    fontsize=15,
    padding=5,
)
extension_defaults = widget_defaults.copy()

# Override volume widget with custom changes
class VolumeOverrideWidget(widget.PulseVolume):
    # Use font for volume icons when emoji is enabled
    def _update_drawer(self):
        if self.emoji:
            if self.volume <= 0:
                self.text = "  "
            elif self.volume < 60:
                self.text = "  "
            elif self.volume >= 60:
                self.text = "  "
        else:
            super()._update_drawer()

# Window and bar customization
foreground_color = catppuccin["rosewater"]
background_color = catppuccin["crust"]
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.WindowName(
                    foreground = foreground_color,
                    background = background_color
                ),
                widget.Spacer(
                    foreground = foreground_color,
                    background = background_color
                ),
                widget.GroupBox(
                    active = foreground_color,
                    inactive = foreground_color,
                    this_current_screen_border = catppuccin["base"],
                    highlight_method = "block",
                    fontshadow = catppuccin["blue"],
                    background = background_color,
                    disable_drag = True
                ),
                widget.Spacer(
                    foreground = foreground_color,
                    background = background_color
                ),
                widget.StatusNotifier(
                    background = background_color
                ),
                VolumeOverrideWidget(
                    emoji = True,
                    foreground = foreground_color,
                    background = background_color
                ),
                widget.Clock(
                    format="%I:%M %p",
                    update_interval=30,
                    foreground = foreground_color,
                    background = background_color
                ),
                widget.QuickExit(
                    default_text = "  ",
                    countdown_format = "  {} ",
                    foreground = catppuccin["red"],
                    background = background_color
                ),
            ],
            size=30,
            margin = [10, 10, 0, 10],
            opacity = 0.99,
            background = background_color,
            border_color = background_color
        ),
    ),
]

# Misc.
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None # Wayland input device config
wmname = "LG3D" # Add for Java apps, unused
