#!/bin/sh

# Config hookups
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Launches anything in .xinitrc.d 
# start some nice programs
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x "$f" ] && . "$f"
# done
# unset f
#fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

# Get the dunst notification daemon going for DBus events
dunst &

#Now for things that love DBus
nm-applet &
guake &

# xscreensaver, OR i3lock ?
# i3lock &

# dropbox &

# Celebrate and then laucnh i3
notify-send "Wilkommen mit N/A" ">^.^<"
# Swap this process to i3 init
exec i3
