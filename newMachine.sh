#!/usr/bin/env bash

# Standard initial parlance to execute after a fresh ubuntu installation

. logging-functions.sh

is_installed () {
    # See if the package is installed, redirect errors to /dev/null.
    # Returns 0 if the package exists, otherwise 1.
    dpkg-query -W --showformat='${Status}\n' "$1" 2> /dev/null | grep "install ok installed"
}

add_repository () {
    warn "Adding repository $1"
    sudo add-apt-repository "$1"
}

install () {
    if [ is_installed "$1" ]; then
        warn "$1 already installed"
    else
        info "Installing $1"
        sudo apt-get install -y "$1"
    fi
}

info "Starting"

read -p "Do you want to run a pre-emptive update (recommended) (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        info "Running a pre-emptive update"
        sudo apt-get -y update 
        sudo apt-get -y upgrade
        sudo apt-get -y dist-upgrade
    ;;
        * )
        warn "Not running a pre-emptive update"
    ;;
esac

read -p "Do you want to add ppa-repositories (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        warn "Adding repositories"
        add_repository "ppa:diesch/testing"
        add_repository "ppa:linrunner/tlp"
        add_repository "ppa:videolan/stable-daily"
        add_repository "ppa:otto-kesselgulasch/gimp"
        add_repository "ppa:webupd8team/java"
        add_repository "ppa:webupd8team/y-ppa-manager"
        add_repository "ppa:hvr/ghc"

        sudo apt-get -y update
    ;;
    * )
        warn "Not adding any ppa-repositories"
    ;;
esac

install 7zip
install arj
install bleachbit
install build-essential
install cabextract
install classicmenu-indicator
install chromium-browser
install nautilus-dropbox
install dropbox
install easytag
install emacs24
install faac
install faad
install ffmpeg2theora
install file-roller
install filezilla
install flac
install flashplugin-installer
install gdb
install gimp
install gimp-data
install gimp-data-extras
install gimp-plugin-registry
install git
install gparted
install gstreamer0.10-plugins-ugly
install gstreamer1.0-libav
install gxine
install htop
install icedax
install id3tool
install id3v2
install lame
install liba52-dev
install libappindicator1
install libc6-dbg
install libdvdnav4
install libdvdread4
install libflac++6
install libjpeg-progs
install libmad0
install libmpeg2-4
install libmpeg3-1
install libswscale-extra-2
install libxine1-ffmpeg
install mencoder
install mpack
install mpeg2dec
install mpeg3-utils
install mpegdemux
install mpg123
install mpg321
install nautilus-open-terminal
install nautilus-script-audio-convert
install openjdk-8-jdk
install p7zip
install p7zip-full
install p7zip-rar
install pandoc
install pandoc-citeproc 
install preload
install python3
install python3-dev
install python-dev 
install python-dev
install python-pip 
install rar
install sharutils
install software-properties-common
install sox
install steam
install synaptic
install tagtool
install tlp 
install tmux
install tlp-rdw
install totem-mozilla
install ubuntu-restricted-extras
install ubuntu-wallpapers*
install unace
install unrar
install unzip
install uudeview
install valgrind
install vim
install vlc
install vorbis-tools
install y-ppa-manager
install zip
install zsh

# Get Chrome (Google Web Browser)
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable

# Upgrade pip and virtual env
install python-pip
sudo pip install --upgrade pip 
sudo pip install --upgrade virtualenv

# Install Rust
curl -sSf https://static.rust-lang.org/rustup.sh | sh

# Install Haskell
install cabal-install-1.22
install ghc-7.10.3


# Change the shell (requires loggin in and out to see the changes)
chsh -s $(which zsh)

# We cannot continue living without oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

python setup.py

# Clean-up
sudo apt-get -f install
sudo apt-get autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean
