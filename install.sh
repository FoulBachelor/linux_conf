#!/bin/sh
SOURCEWD="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export STUBBE_INSTALLER_DIR=$SOURCEWD
echo "Welcome to the Stubbe Terminal Rice"
echo "This script will modify your shell, terminal emulator, multiplexer and shell theme"
echo "Which package manager do you use?"
echo -n "(apt, pacman, dnf, brew):"
read -r package_manager
case $package_manager in
    apt|apt-get|a)
        echo "Will Install using APT"
        pkgmn="apt"
    ;;
    pacman|yay|yaourt|p)
        echo "Will Install using PACMAN"
        pkgmn="pacman"
    ;;
    dnf|yum|d)
        echo "Will Install using DNF"
        pkgmn="dnf"
    ;;
    brew|b)
        echo "Unknown Linux Distro"
        echo "Will use BREW"
        pkgmn="brew"
    ;;
esac
case $pkgmn in
    apt)
        sudo chmod +x $SOURCEWD/sh/$pkgmn.sh
        $SOURCEWD/sh/$pkgmn.sh
    ;;
    pacman)
        sudo chmod +x $SOURCEWD/sh/$pkgmn.sh
        $SOURCEWD/sh/$pkgmn.sh
    ;;
    dnf)
        sudo chmod +x $SOURCEWD/sh/$pkgmn.sh
        $SOURCEWD/sh/$pkgmn.sh
    ;;
    brew)
        sudo chmod +x $SOURCEWD/sh/$pkgmn.sh
        $SOURCEWD/sh/$pkgmn.sh
    ;;
esac
echo "Cleaning up Downloads";
rm -rf $SOURCEWD && cd $HOME;
echo "Done";
