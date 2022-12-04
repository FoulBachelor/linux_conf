#!/bin/sh
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
mkdir -p $HOME/.stubbe/tmp && cd $HOME/.stubbe/tmp;
mkdir -p $HOME/.stubbe/builds;
mkdir -p $HOME/.stubbe/config;
touch -a $HOME/.profile;
case $pkgmn in
  apt)
    echo "Installing Dependencies"
    exec $install_command cmake pkg-config libfreetype6-dev libfontconfig1-dev libxft-dev libx11-dev libxcb-xfixes0-dev libxkbcommon-dev python3 git-all curl zip tar git-all tmux zsh ripgrep neovim sshfs 
    echo "Installing JetBrainsMono Nerd Font"
    curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
    mkdir -p $HOME/.fonts
    unzip JetBrainsMono.zip $HOME/.fonts
    fc-cache -f -v
    echo "Install Suckless Terminal"
    git clone https://git.suckless.org/st $HOME/.stubbe/builds/st
    cd $HOME/.stubbe/builds/st
    cp ./config/st/config.h ./config.h
    sudo make clean install
    echo "export TERMINAL=st" >> $HOME/.profile
    echo "Setting zsh as default shell"
    chsh -s $(whereis zsh | cut -d' ' -f2)
    cp ./config/zsh/.zshrc $HOME/.stubbe/config/.zshrc
    ln -s $HOME/.stubbe/config/.zshrc $HOME/.zshrc
    echo "Installing Aliases and Personal Functions"
    cp ./config/aliases/.aliasrc $HOME/.stubbe/config/.aliasrc
    echo "Adding st_config and st_build to aliasrc"
    echo "alias st_config='$EDITOR $HOME/.stubbe/builds/st/config.h'" >> $HOME/.stubbe/config/.aliasrc
    echo "alias st_build='cd $HOME/.stubbe/builds/st && sudo make clean install && cd $HOME && echo reopen terminal!'" >> $HOME/.stubbe/config/.aliasrc
    ln -s $HOME/.stubbe/config/.aliasrc $HOME/.aliasrc
    echo "Installing TMUX Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp ./config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf
    ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf
    echo "Installing NvChad"
    rm -rf $HOME/.local/share/nvim
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    ;;
  pacman)
    exec $update_command
    exec $upgrade_command
    echo "Installing Dependencies"
    exec $install_command --overwrite \* python-cairo
    exec $install_command cmake freetype2 fontconfig pkg-config make python libxcb libxkbcommon zip tar git-all tmux zsh ripgrep neovim sshfs
    echo "Installing JetBrainsMono Nerd Font"
    curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
    mkdir -p $HOME/.fonts
    unzip JetBrainsMono.zip $HOME/.fonts
    fc-cache -f -v
    echo "Install Suckless Terminal"
    git clone https://git.suckless.org/st $HOME/.stubbe/builds/st
    cd $HOME/.stubbe/builds/st
    cp ./config/st/config.h ./config.h
    sudo make clean install
    echo "export TERMINAL=st" >> $HOME/.profile
    echo "Setting zsh as default shell"
    chsh -s $(whereis zsh | cut -d' ' -f2)
    cp ./config/zsh/.zshrc $HOME/.stubbe/config/.zshrc
    ln -s $HOME/.stubbe/config/.zshrc $HOME/.zshrc
    echo "Installing Aliases and Personal Functions"
    cp ./config/aliases/.aliasrc $HOME/.stubbe/config/.aliasrc
    echo "Adding st_config and st_build to aliasrc"
    echo "alias st_config='$EDITOR $HOME/.stubbe/builds/st/config.h'" >> $HOME/.stubbe/config/.aliasrc
    echo "alias st_build='cd $HOME/.stubbe/builds/st && sudo make clean install && cd $HOME && echo reopen terminal!'" >> $HOME/.stubbe/config/.aliasrc
    ln -s $HOME/.stubbe/config/.aliasrc $HOME/.aliasrc
    echo "Installing TMUX Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp ./config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf
    ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf
    echo "Installing NvChad"
    rm -rf $HOME/.local/share/nvim
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    ;;
  dnf)
    exec $update_command
    exec $upgrade_command
    echo "Installing Dependencies"
    exec $install_command cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++ zip tar git-all tmux zsh ripgrep neovim sshfs
    echo "Installing JetBrainsMono Nerd Font"
    curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
    mkdir -p $HOME/.fonts
    unzip JetBrainsMono.zip $HOME/.fonts
    fc-cache -f -v
    echo "Install Suckless Terminal"
    git clone https://git.suckless.org/st $HOME/.stubbe/builds/st
    cd $HOME/.stubbe/builds/st
    cp ./config/st/config.h ./config.h
    sudo make clean install
    echo "export TERMINAL=st" >> $HOME/.profile
    echo "Setting zsh as default shell"
    chsh -s $(whereis zsh | cut -d' ' -f2)
    cp ./config/zsh/.zshrc $HOME/.stubbe/config/.zshrc
    ln -s $HOME/.stubbe/config/.zshrc $HOME/.zshrc
    echo "Installing Aliases and Personal Functions"
    cp ./config/aliases/.aliasrc $HOME/.stubbe/config/.aliasrc
    echo "Adding st_config and st_build to aliasrc"
    echo "alias st_config='$EDITOR $HOME/.stubbe/builds/st/config.h'" >> $HOME/.stubbe/config/.aliasrc
    echo "alias st_build='cd $HOME/.stubbe/builds/st && sudo make clean install && cd $HOME && echo reopen terminal!'" >> $HOME/.stubbe/config/.aliasrc
    ln -s $HOME/.stubbe/config/.aliasrc $HOME/.aliasrc
    echo "Installing TMUX Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp ./config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf
    ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf
    echo "Installing NvChad"
    rm -rf $HOME/.local/share/nvim
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    ;;
  brew)
    which -s brew
    if [[ $? != 0 ]] ; then
      curl -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
    fi
    exec $update_command
    exec $upgrade_command
    echo "Installing Dependencies"
    exec $install_command tmux zsh neovim ripgrep git-archive-all
    echo "Installing JetBrainsMono Nerd Font"
    curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
    mkdir -p $HOME/.fonts
    unzip JetBrainsMono.zip $HOME/.fonts
    fc-cache -f -v
    echo "Install Suckless Terminal"
    git clone https://git.suckless.org/st $HOME/.stubbe/builds/st
    cd $HOME/.stubbe/builds/st
    cp ./config/st/config.h ./config.h
    sudo make clean install
    echo "export TERMINAL=st" >> $HOME/.profile
    echo "Setting zsh as default shell"
    chsh -s $(whereis zsh | cut -d' ' -f2)
    cp ./config/zsh/.zshrc $HOME/.stubbe/config/.zshrc
    ln -s $HOME/.stubbe/config/.zshrc $HOME/.zshrc
    echo "Installing Aliases and Personal Functions"
    cp ./config/aliases/.aliasrc $HOME/.stubbe/config/.aliasrc
    echo "Adding st_config and st_build to aliasrc"
    echo "alias st_config='$EDITOR $HOME/.stubbe/builds/st/config.h'" >> $HOME/.stubbe/config/.aliasrc
    echo "alias st_build='cd $HOME/.stubbe/builds/st && sudo make clean install && cd $HOME && echo reopen terminal!'" >> $HOME/.stubbe/config/.aliasrc
    ln -s $HOME/.stubbe/config/.aliasrc $HOME/.aliasrc
    echo "Installing TMUX Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp ./config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf
    ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf
    echo "Installing NvChad"
    rm -rf $HOME/.local/share/nvim
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    ;;
esac

