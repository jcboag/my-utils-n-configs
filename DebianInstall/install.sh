# Script to restore part of debian system (eg packages) after reinstall

## Remote Packages ##
cd "$HOME/Projects/Debian Install"
xargs -a pkglist sudo apt install

## Local Packages ##
REPOS="$HOME/.local/repos"

# gluqlo
if [ -e $REPOS/gluqlo ] && [ ! -e ~/.local/bin/gluqlo ]; then
    cp "$REPOS/gluqlo/gluqlo" -t ".local/bin"
fi

./btdongle.sh
./steam.sh
./mvcpg.sh
