if [ "$0" = "/usr/sbin/lightdm-session" -a "$DESKTOP_SESSION" = "i3" ]
then
    export $(gnome-keyring-daemon -s)
fi

export PATH="$PATH:$HOME/.local/bin"

export TERMINAL=kitty
export BROWSER=google-chrome-stable
