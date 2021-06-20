# -*- coding: utf-8 -*-
import os
import psutil
import socket
import subprocess

from libqtile import bar, hook, layout, qtile
from libqtile.config import Click, Drag, Group, Key, Screen, DropDown, ScratchPad
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.widget import (Battery, Clock, CurrentLayout, CurrentLayoutIcon,
                             GroupBox, Notify, Maildir, Volume, Prompt, Sep,
                             Spacer, Systray, TaskList, TextBox, Memory, Mpd2,
                             Image)

   #     from libqtile.config import 
DEBUG = os.environ.get("DEBUG")

GREY = "#222222"
DARK_GREY = "#111111"
BLUE = "#007fdf"
DARK_BLUE = "#002a4a"
ORANGE = "#dd6600"
DARK_ORANGE = "#371900"


def window_to_previous_column_or_group(qtile):
    layout = qtile.current_group.layout
    group_index = qtile.groups.index(qtile.current_group)
    previous_group_name = qtile.current_group.get_previous_group().name

    if layout.name != "columns":
        qtile.current_window.togroup(previous_group_name)
    elif layout.current == 0 and len(layout.cc) == 1:
        if group_index != 0:
            qtile.current_window.togroup(previous_group_name)
    else:
        layout.cmd_shuffle_left()


def window_to_next_column_or_group(qtile):
    layout = qtile.current_group.layout
    group_index = qtile.groups.index(qtile.current_group)
    next_group_name = qtile.current_group.get_next_group().name

    if layout.name != "columns":
        qtile.current_window.togroup(next_group_name)
    elif layout.current + 1 == len(layout.columns) and len(layout.cc) == 1:
        if group_index + 1 != len(qtile.groups):
            qtile.current_window.togroup(next_group_name)
    else:
        layout.cmd_shuffle_right()


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    if len(qtile.screens) == 1:
        previous_switch = getattr(qtile, "previous_switch", None)
        qtile.previous_switch = qtile.current_group
        return qtile.current_screen.toggle_group(previous_switch)

    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


def init_keys():
    keys = [
        Key([mod], "Left", lazy.screen.prev_group(skip_empty=True)),
        Key([mod], "Right", lazy.screen.next_group(skip_empty=True)),

        Key([mod, "shift"], "Left", lazy.function(window_to_previous_column_or_group)),
        Key([mod, "shift"], "Right", lazy.function(window_to_next_column_or_group)),

        Key([mod, "control"], "Up", lazy.layout.grow_up()),
        Key([mod, "control"], "Down", lazy.layout.grow_down()),
        Key([mod, "control"], "Left", lazy.layout.grow_left()),
        Key([mod, "control"], "Right", lazy.layout.grow_right()),

        Key([mod, "mod1"], "Left", lazy.prev_screen()),
        Key([mod, "mod1"], "Right", lazy.next_screen()),

        Key([mod, "shift", "mod1"], "Left", lazy.function(window_to_previous_screen)),
        Key([mod, "shift", "mod1"], "Right", lazy.function(window_to_next_screen)),

        Key([mod], "t", lazy.function(switch_screens)),

        Key([mod], "Up", lazy.group.prev_window()),
        Key([mod], "Down", lazy.group.next_window()),

        Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),

        Key([mod], "space", lazy.next_layout()),
        Key([mod, "shift"], "space", lazy.prev_layout()),

        ### Window controls
         Key([mod], "j",
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], "k",
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, "shift"], "j",
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "k",
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], "h",
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "l",
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),

        Key([mod], "f", lazy.window.toggle_floating()),
        Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),
        Key([mod], "b", lazy.window.bring_to_front()),
        Key([mod], "s", lazy.layout.toggle_split()),

        Key([mod], "g", lazy.labelgroup()),
        Key([mod], "r", lazy.spawn("dmenu_run")),
        Key([mod], "p", lazy.spawn("passmenu")),
        Key([mod, "mod1"], "w", lazy.spawn(browser)),
        Key([mod], "Return", lazy.spawn(terminal)),
        Key([mod, "shift"], "c", lazy.window.kill()),

        Key([mod, "shift"], "r", lazy.restart()),
        Key([mod, "shift"], "q", lazy.shutdown()),
        Key([mod], "v", lazy.validate_config()),

        Key([], "Scroll_Lock", lazy.spawn(screenlocker)),
        
    ]
   # if DEBUG:
    keys += [
        Key([mod], "Tab", lazy.layout.next()),
        Key([mod, "shift"], "Tab", lazy.layout.previous()),
        Key([mod, "shift"], "f", lazy.layout.flip()),
        Key([mod], "y", lazy.group["scratch"].dropdown_toggle("term"))
    ]
    return keys


def init_mouse():
    mouse = [Drag([mod], "Button1", lazy.window.set_position_floating(),
                  start=lazy.window.get_position()),
             Drag([mod], "Button3", lazy.window.set_size_floating(),
                  start=lazy.window.get_size()),
             Click([mod], "Button2", lazy.window.kill())]
    if DEBUG:
        mouse += [Drag([mod, "shift"], "Button1", lazy.window.set_position(),
                       start=lazy.window.get_position())]
    return mouse


def init_groups():
    def _inner(key, name):
        keys.append(Key([mod], key, lazy.group[name].toscreen()))
        keys.append(Key([mod, "shift"], key, lazy.window.togroup(name)))
        return Group(name)

    groups = [("dead_grave", "00")]
    groups += [(str(i), "0" + str(i)) for i in range(1, 10)]
    groups += [("0", "10"), ("minus", "11"), ("equal", "12")]
    groups = [_inner(*i) for i in groups]

   # if DEBUG:
   #     from libqtile.config import DropDown, ScratchPad
    dropdowns = [DropDown("term", terminal, x=0.125, y=0.25,
                              width=0.75, height=0.5, opacity=0.8,
                              on_focus_lost_hide=True)]
    groups.append(ScratchPad("scratch", dropdowns))
    return groups


def init_floating_layout():
    return layout.Floating(border_focus=ORANGE)


def init_layouts():
    margin = 0
    if len(qtile.core.conn.pseudoscreens) > 1:
        margin = 8
    kwargs = dict(margin=margin, border_width=1, border_normal=GREY,
                  border_focus=BLUE, border_focus_stack=ORANGE)
    layouts = [
        layout.Max(),
        layout.Columns(border_on_single=True, num_columns=2, grow_amount=5,
                       **kwargs)
    ]

    if DEBUG:
        layouts += [
            floating_layout, layout.Bsp(fair=False), layout.Zoomy(), layout.Tile(),
            layout.Matrix(), layout.TreeTab(), layout.MonadTall(margin=10),
            layout.RatioTile(), layout.Stack()
        ]
    return layouts


def init_widgets():
    widgets = [
        Image(filename = "~/.config/qtile/icons/python.png",
                       scale = "False",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                       ),
        GroupBox(fontsize=9, padding=2, borderwidth=1, urgent_border=DARK_BLUE,
                 disable_drag=True, highlight_method="border",
                 this_screen_border=DARK_BLUE, other_screen_border=DARK_ORANGE,
                 this_current_screen_border=BLUE,
                 other_current_screen_border=ORANGE),
        CurrentLayoutIcon(scale=0.6, padding=8),
        TextBox(text="◤", fontsize=45, padding=-1, foreground=DARK_GREY,
                background=GREY),

        TaskList(borderwidth=0, highlight_method="block", background=GREY,
                 border=DARK_GREY, urgent_border=DARK_BLUE,
                 markup_floating="<i>{}</i>", markup_minimized="<s>{}</s>"),

        Prompt(background=GREY),
        Systray(background=GREY),
        TextBox(text="◤", fontsize=45, padding=-1,
                foreground=GREY, background=DARK_GREY),
        Notify(fmt=" 🔥 {} "),
        TextBox(text = '🎵', padding = 0),
        Mpd2(padding = 5),
        TextBox(text = '🧠',padding = 0),

        Memory(mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + 'htop')},
                       padding = 5
                       ),
        Maildir(maildir_path = '/data/Mail/',
                       sub_folders = [{"path": "INBOX", "label": " "}],
                       update_interval = 60, padding = 5
                       ),
        TextBox(text = ":"),
        Volume(padding = 5),
        Clock(format=" ⏱ %H:%M  <span color='#666'>%A %d-%m-%Y</span>  ")
    ]
    if DEBUG:
        widgets += [Sep(), CurrentLayout()]
    return widgets


@hook.subscribe.client_new
def set_floating(window):
    floating_classes = ("nm-connection-editor", "pavucontrol")
    try:
        if window.window.get_wm_class()[0] in floating_classes:
            window.floating = True
    except IndexError:
        pass


@hook.subscribe.screen_change
def set_screens(event):
    logger.debug("Handling event: {}".format(event))
    subprocess.run(["autorandr", "--change"])
    qtile.restart()


@hook.subscribe.startup_complete
def set_logging():
    if DEBUG:
        qtile.cmd_debug()



if __name__ in ["config", "__main__"]:
    local_bin = os.path.expanduser("~") + "/.local/bin"
    if local_bin not in os.environ["PATH"]:
        os.environ["PATH"] = "{}:{}".format(local_bin, os.environ["PATH"])

    mod = "mod4"
    browser = "firefox"
    terminal = "kitty"
    screenlocker = "i3lock -d"
    hostname = socket.gethostname()
    cursor_warp = True
    focus_on_window_activation = "never"

    auto_fullscreen = False
    keys = init_keys()
    mouse = init_mouse()
    groups = init_groups()
    floating_layout = init_floating_layout()
    layouts = init_layouts()
    widgets = init_widgets()
    bar = bar.Bar(widgets=widgets, size=22, opacity=1)
    screens = [Screen(top=bar)]
    widget_defaults = {"font": "DejaVu", "fontsize": 14, "padding": 2,
                       "background": DARK_GREY}




@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


