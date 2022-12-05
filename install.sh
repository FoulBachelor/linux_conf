#!/bin/sh
SOURCEWD="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "Welcome to the Stubbe Terminal Rice"
echo "This script will modify your shell, terminal emulator, multiplexer and shell theme"
echo "Which package manager do you use?"
echo -n "(apt, pacman, dnf):"
read -r package_manager
case $package_manager in
    apt|apt-get)
        install_command="sudo apt -y install"
        update_command="sudo apt -y update"
        upgrade_command="sudo apt -y upgrade"
        pkgmn="apt"
    ;;
    pacman|yay|yaourt)
        install_command="sudo pacman -S"
        update_command="sudo pacman -Syu"
        upgrade_command="sudo pacman -Syu"
        pkgmn="pacman"
    ;;
    dnf|yum)
        install_command="sudo dnf install"
        update_command="sudo dnf check-update"
        upgrade_command="sudo dnf upgrade"
        pkgmn="dnf"
    ;;
    *)
        echo "Unknown Linux Distro"
        echo "Will Attempt to use Homebrew"
        install_command="sudo brew install"
        update_command="sudo brew update"
        upgrade_command="sudo brew upgrade"
        pkgmn="brew"
    ;;
esac
echo "Running system update and installing dependencies!"
mkdir -p $HOME/.stubbe/builds;
mkdir -p $HOME/.stubbe/config;
touch -a $HOME/.profile;
case $pkgmn in
    apt)
        echo "Due to apt being shit, it will quit this script after running update and intall"
        echo "There for please answer if you are sure dependencies are installed."
        echo "If yes, it will install my script, if not it will install dependencies. Please rerun the script after."
        echo -n "Have you installed dependencies already? (y)es / (n)o:"
        read -r install_dep
        if [ $install_dep = 'n' || $install_dep = 'no' ]; then
          echo "Installing Dependencies";
          exec $install_command cmake pkg-config libfreetype6-dev libfontconfig1-dev libxft-dev libx11-dev libxcb-xfixes0-dev libxkbcommon-dev python3 git-all curl zip tar git-all tmux zsh ripgrep sshfs  < "/dev/null";
        fi
        echo "Installing NeoVim Terminal IDE";
        wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz;
        tar xzvf ./nvim-*.tar.gz;
        rm -rf $HOME/.stubbe/builds/nvim;
        mkdir -p $HOME/.stubbe/builds/nvim;
        cp -rf  $SOURCEWD/nvim-linux64/* $HOME/.stubbe/builds/nvim;
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
        echo "Installing TMUX Plugin Manager";
        rm -rf $HOME/.tmux/plugins/tpm;
        git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm;
        cp $SOURCEWD/config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf;
        rm -f $HOME/.tmux.conf;
        ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf;
        echo "Installing NvChad";
        rm -rf $HOME/.local/share/nvim $HOME/.config/nvim;
        git clone https://github.com/NvChad/NvChad $HOME/.config/nvim --depth 1 && nvim;
    ;;
    pacman)
        echo -n "Have you installed dependencies already? (y)es / (n)o:";
        read -r install_dep;
        if [ $install_dep = 'n' || $install_dep = 'no' ]; then
          echo "Installing Dependencies";
          exec $upgrade_command --overwrite \* python-cairo;
          exec $install_command cmake freetype2 fontconfig pkg-config make python libxcb libxkbcommon zip tar git-all tmux zsh ripgrep sshfs;
        fi
        echo "Installing NeoVim Terminal IDE";
        wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz;
        tar xzvf ./nvim-*.tar.gz;
        rm -rf $HOME/.stubbe/builds/nvim;
        mkdir -p $HOME/.stubbe/builds/nvim;
        cp -rf  $SOURCEWD/nvim-linux64/* $HOME/.stubbe/builds/nvim;
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
        echo "Installing TMUX Plugin Manager";
        rm -rf $HOME/.tmux/plugins/tpm;
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
        cp $SOURCEWD/config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf;
        rm -f $HOME/.tmux.conf;
        ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf;
        echo "Installing NvChad";
        rm -rf $HOME/.local/share/nvim $HOME/.config/nvim;
        git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim;
    ;;
    dnf)
        echo -n "Have you installed dependencies already? (y)es / (n)o:";
        if [ $install_dep = 'n' || $install_dep = 'no' ]; then
          exec $update_command;
          echo "Installing Dependencies";
          exec $install_command cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++ zip tar git-all tmux zsh ripgrep sshfs;
        fi
        echo "Installing NeoVim Terminal IDE";
        wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz;
        tar xzvf ./nvim-*.tar.gz;
        rm -rf $HOME/.stubbe/builds/nvim;
        mkdir -p $HOME/.stubbe/builds/nvim;
        cp -rf  $SOURCEWD/nvim-linux64/* $HOME/.stubbe/builds/nvim;
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
        sudo make clean install
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
        echo "Installing TMUX Plugin Manager";
        rm -rf $HOME/.tmux/plugins/tpm;
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
        cp $SOURCEWD/config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf;
        rm -f $HOME/.tmux.conf;
        ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf;
        echo "Installing NvChad";
        rm -rf $HOME/.local/share/nvim $HOME/.config/nvim;
        git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim;
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
rm -rf ./*.zip ./*.tar.gz;
echo "Done";
