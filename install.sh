#!/bin/sh
SOURCEWD="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export STUBBE_INSTALLER_DIR=$SOURCEWD
echo "Welcome to the Stubbe Terminal Rice"
echo "This script will modify your shell, terminal emulator, multiplexer and shell theme"
echo "Which package manager do you use?"
echo -n "(apt, pacman, dnf, brew):"
read -r package_manager
case $package_manager in
    apt|apt-get)
        echo "Will Install using APT"
        pkgmn="apt"
    ;;
    pacman|yay|yaourt)
        echo "Will Install using PACMAN"
        pkgmn="pacman"
    ;;
    dnf|yum)
        echo "Will Install using DNF"
        pkgmn="dnf"
    ;;
    brew|*)
        echo "Unknown Linux Distro"
        echo "Will use BREW"
        pkgmn="brew"
    ;;
esac
echo "Running system update and installing dependencies!"
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
        which -s brew
        if [[ $? != 0 ]] ; then
            curl -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        echo -n "Have you installed dependencies already? (y)es / (n)o:";
        if [ $install_dep = 'n' || $install_dep = 'no' ]; then
          exec $update_command;
          exec $upgrade_command;
          echo "Installing Dependencies";
          exec $install_command tmux zsh ripgrep git-archive-all;
        fi
        echo "Installing NeoVim Terminal IDE";
        wget https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz
		xattr -c ./nvim-macos.tar.gz
        tar xzvf ./nvim-*.tar.gz;
        rm -rf $HOME/.stubbe/builds/nvim;
        mkdir -p $HOME/.stubbe/builds/nvim;
        cp -rf  $SOURCEWD/nvim-macos/* $HOME/.stubbe/builds/nvim;
        rm -rf /usr/bin/nvim;
        sudo ln -s $HOME/.stubbe/builds/nvim/bin/nvim /usr/bin/nvim;
        echo "Installing JetBrainsMono Nerd Font";
        curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip;
        mkdir -p $HOME/.fonts;
        unzip JetBrainsMono.zip $HOME/.fonts;
        fc-cache -f;
        echo "Install Suckless Terminal";
        rm -rf $HOME/.stubbe/builds/st;
        git clone https://git.suckless.org/st $HOME/.stubbe/builds/st;
        cd $HOME/.stubbe/builds/st;
        cp $SOURCEWD/config/st/config.h $HOME/.stubbe/builds/st/config.h;
        sudo make clean install;
        cd $SOURCEWD;
        echo "export TERMINAL=st" >> $HOME/.profile;
        echo "Setting zsh as default shell";
        chsh -s $(whereis zsh | cut -d' ' -f2);
        cp $SOURCEWD/config/zsh/.zshrc $HOME/.stubbe/config/.zshrc;
        rm -f $HOME/.zshrc;
        ln -s $HOME/.stubbe/config/.zshrc $HOME/.zshrc;
        echo "Installing Aliases and Personal Functions";
        cp $SOURCEWD/config/aliases/.aliasrc $HOME/.stubbe/config/.aliasrc;
        echo "Adding st_config and st_build to aliasrc";
        echo "alias st_config='$EDITOR $HOME/.stubbe/builds/st/config.h'" >> $HOME/.stubbe/config/.aliasrc;
        echo "alias st_build='cd $HOME/.stubbe/builds/st && sudo make clean install && cd $HOME && echo reopen terminal!'" >> $HOME/.stubbe/config/.aliasrc;
        rm -f $HOME/.aliasrc;
        ln -s $HOME/.stubbe/config/.aliasrc $HOME/.aliasrc;
        echo "Installing TMUX Plugin Manager"
        rm -rf $HOME/.tmux/plugins/tpm;
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
        cp $SOURCEWD/config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf;
        rm -f $HOME/.tmux.conf;
        ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf;
        echo "Installing NvChad";
        rm -rf $HOME/.local/share/nvim $HOME/.config/nvim;
        git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim;
    ;;
esac
echo "Cleaning up Downloads";
cd $SOURCEWD;
rm -rf ./*.zip ./*.tar.gz nvim-*
echo "Done";
