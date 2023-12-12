from libqtile.config import KeyChord, Key
from libqtile.lazy import lazy

mod = "mod4"

mod = "mod4"  # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"  # My terminal of choice
myBrowser = "brave"  # My browser of choice

launcher = "/home/aj/.dotfiles/scripts/launcher.sh"


def nextSong():
    lazy.spawn(
        'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next'
    )


def previousSong():
    lazy.spawn(
        'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous'
    )


def getKeys():
    return [
        ### The essentials
        Key([mod],
            "Return",
            lazy.spawn(myTerm + " -e zsh"),
            desc='Launches My Terminal'),
        Key([mod, "shift"],
            "Return",
            lazy.spawn(launcher),
            desc='Run Launcher'),
        Key([mod], "b", lazy.spawn(myBrowser), desc='Qutebrowser'),
        Key([mod], "Tab", lazy.next_layout(), desc='Toggle through layouts'),
        Key([mod, "shift"], "c", lazy.window.kill(),
            desc='Kill active window'),
        Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),
        Key([mod, "shift"], "q", lazy.shutdown(), desc='Shutdown Qtile'),
        Key(["control", "shift"],
            "e",
            lazy.spawn("emacsclient -c -a emacs"),
            desc='Doom Emacs'),
        Key([mod, "shift"],
            "p",
            lazy.spawn("dm-tool lock"),
            desc='Lock the screen'),
        Key([mod, "shift"],
            "s",
            lazy.spawn("flameshot gui"),
            desc='Open screenshot tool'),

        ### Switch focus to specific monitor (out of three)
        Key([mod], "w", lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
        Key([mod], "e", lazy.to_screen(1), desc='Keyboard focus to monitor 2'),
        Key([mod], "r", lazy.to_screen(2), desc='Keyboard focus to monitor 3'),
        ### Switch focus of monitors
        Key([mod],
            "period",
            lazy.next_screen(),
            desc='Move focus to next monitor'),
        Key([mod],
            "comma",
            lazy.prev_screen(),
            desc='Move focus to prev monitor'),
        ### Treetab controls
        Key([mod, "shift"],
            "h",
            lazy.layout.move_left(),
            desc='Move up a section in treetab'),
        Key([mod, "shift"],
            "l",
            lazy.layout.move_right(),
            desc='Move down a section in treetab'),
        ### Window controls
        Key([mod],
            "j",
            lazy.layout.down(),
            desc='Move focus down in current stack pane'),
        Key([mod],
            "k",
            lazy.layout.up(),
            desc='Move focus up in current stack pane'),
        Key([mod, "shift"],
            "j",
            lazy.layout.shuffle_down(),
            lazy.layout.section_down(),
            desc='Move windows down in current stack'),
        Key([mod, "shift"],
            "k",
            lazy.layout.shuffle_up(),
            lazy.layout.section_up(),
            desc='Move windows up in current stack'),
        Key([mod],
            "h",
            lazy.layout.shrink(),
            lazy.layout.decrease_nmaster(),
            desc=
            'Shrink window (MonadTall), decrease number in master pane (Tile)'
            ),
        Key([mod],
            "l",
            lazy.layout.grow(),
            lazy.layout.increase_nmaster(),
            desc=
            'Expand window (MonadTall), increase number in master pane (Tile)'
            ),
        Key([mod],
            "n",
            lazy.layout.normalize(),
            desc='normalize window size ratios'),
        Key([mod],
            "m",
            lazy.layout.maximize(),
            desc='toggle window between minimum and maximum sizes'),
        Key([mod, "shift"],
            "f",
            lazy.window.toggle_floating(),
            desc='toggle floating'),
        Key([mod],
            "f",
            lazy.window.toggle_fullscreen(),
            desc='toggle fullscreen'),
        ### Stack controls
        Key([mod, "shift"],
            "Tab",
            lazy.layout.rotate(),
            lazy.layout.flip(),
            desc='Switch which side main pane occupies (XmonadTall)'),
        Key([mod],
            "space",
            lazy.layout.next(),
            desc='Switch window focus to other pane(s) of stack'),
        Key([mod, "shift"],
            "space",
            lazy.layout.toggle_split(),
            desc='Toggle between split and unsplit sides of stack'),
        # Media controls
        Key([], "XF86AudioRaiseVolume",
            lazy.spawn("amixer sset 'Master' 60%")),
        Key([], "XF86AudioLowerVolume",
            lazy.spawn("amixer sset 'Master' 30%")),
        Key([], "XF86AudioNext", nextSong()),
        Key([], "XF86AudioPrev", previousSong()),
        # Emacs programs launched using the key chord CTRL+e followed by 'key'
        KeyChord(["control"], "e", [
            Key([],
                "e",
                lazy.spawn("emacsclient -c -a 'emacs'"),
                desc='Launch Emacs'),
            Key([],
                "b",
                lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"),
                desc='Launch ibuffer inside Emacs'),
            Key([],
                "d",
                lazy.spawn("emacsclient -c -a 'emacs' --eval '(dired nil)'"),
                desc='Launch dired inside Emacs'),
            Key([],
                "i",
                lazy.spawn("emacsclient -c -a 'emacs' --eval '(erc)'"),
                desc='Launch erc inside Emacs'),
            Key([],
                "m",
                lazy.spawn("emacsclient -c -a 'emacs' --eval '(mu4e)'"),
                desc='Launch mu4e inside Emacs'),
            Key([],
                "n",
                lazy.spawn("emacsclient -c -a 'emacs' --eval '(elfeed)'"),
                desc='Launch elfeed inside Emacs'),
            Key([],
                "s",
                lazy.spawn("emacsclient -c -a 'emacs' --eval '(eshell)'"),
                desc='Launch the eshell inside Emacs'),
            Key([],
                "v",
                lazy.spawn(
                    "emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"),
                desc='Launch vterm inside Emacs')
        ]),
        # Dmenu scripts launched using the key chord SUPER+p followed by 'key'
        KeyChord([mod], "p", [
            Key([],
                "e",
                lazy.spawn("./dmscripts/dm-confedit"),
                desc='Choose a config file to edit'),
            Key([],
                "i",
                lazy.spawn("./dmscripts/dm-maim"),
                desc='Take screenshots via dmenu'),
            Key([],
                "k",
                lazy.spawn("./dmscripts/dm-kill"),
                desc='Kill processes via dmenu'),
            Key([],
                "l",
                lazy.spawn("./dmscripts/dm-logout"),
                desc='A logout menu'),
            Key([],
                "m",
                lazy.spawn("./dmscripts/dm-man"),
                desc='Search manpages in dmenu'),
            Key([],
                "o",
                lazy.spawn("./dmscripts/dm-bookman"),
                desc='Search your qutebrowser bookmarks and quickmarks'),
            Key([],
                "r",
                lazy.spawn("./dmscripts/dm-reddit"),
                desc='Search reddit via dmenu'),
            Key([],
                "s",
                lazy.spawn("./dmscripts/dm-websearch"),
                desc='Search various search engines via dmenu'),
            Key([],
                "p",
                lazy.spawn("passmenu"),
                desc='Retrieve passwords with dmenu')
        ])
    ]
