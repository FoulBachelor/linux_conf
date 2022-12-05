#!/bin/bash
echo "Do you want to check and install dependencies?"
read -p "(y)es or (n)o: " yn
case $yn in
    [Yy]* )
        echo "Checking system for updates"
        sudo pacman -Syyuu
        sleep 3
        echo "Installing Prerequisites"
        sudo pacman -Ryy neovim
        sudo pacman -Syy --overwrite \* python-cairo
        sudo pacman -Syy cmake
        sudo pacman -Syy freetype2
        sudo pacman -Syy fontconfig
        sudo pacman -Syy pkg-config
        sudo pacman -Syy make
        sudo pacman -Syy python
        sudo pacman -Syy libxcb
        sudo pacman -Syy libxkbcommon
        sudo pacman -Syy zip
        sudo pacman -Syy git
        sudo pacman -Syy curl
        sudo pacman -Syy wget
        sudo pacman -Syy tar
        sudo pacman -Syy tmux
        sudo pacman -Syy zsh
        sudo pacman -Syy ripgrep
        sudo pacman -Syy sshfs
        sleep 3
        echo "Checking updates post-install"
        sudo pacman -Syyuu
        sleep 3
    ;;
    [Nn]* )
        echo "Continuing without checking dependencies"
    ;;
esac
rm -rf $HOME/.stubbe/builds/nvim
rm -rf $HOME/.config/nvim
rm -rf $HOME/.local/share/nvim
rm -rf $HOME/.cache/nvim
rm -rf $HOME/.stubbe/builds/st
rm -rf $HOME/.zshrc
rm -rf $HOME/.aliasrc
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.tmux/plugins/tpm
rm -rf /usr/bin/nvim
unlink /usr/bin/nvim
echo "Making Directories and .Profile"
mkdir -p $HOME/.stubbe/builds
mkdir -p $HOME/.stubbe/builds/nvim
mkdir -p $HOME/.stubbe/builds/st
mkdir -p $HOME/.stubbe/config
mkdir -p $HOME/.fonts
mkdir -p $STUBBE_INSTALLER_DIR/font_tmp
touch -a $HOME/.profile
echo "Installing RUSTUP and CARGO"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Downloading NeoVim, a newer version of Vim, a newer version of Vi, an older version of 5"
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf ./nvim-*.tar.gz
cp -rf  $STUBBE_INSTALLER_DIR/nvim-linux64/* $HOME/.stubbe/builds/nvim
sudo ln -s $HOME/.stubbe/builds/nvim/bin/nvim /usr/bin/nvim
echo "Installing JetBrainsMono Nerd Font"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
mv JetBrainsMono.zip $STUBBE_INSTALLER_DIR/font_tmp
unzip $STUBBE_INSTALLER_DIR/font_tmp/JetBrainsMono.zip
cp -rf $STUBBE_INSTALLER_DIR/font_tmp/* $HOME/.fonts
rm -rf $STUBBE_INSTALLER_DIR/font_tmp
fc-cache -f
echo "Install ST Terminal"
git clone https://git.suckless.org/st $HOME/.stubbe/builds/st
cp $STUBBE_INSTALLER_DIR/config/st/config.h $HOME/.stubbe/builds/st/config.h
cd $HOME/.stubbe/builds/st
sudo make clean install
cd $STUBBE_INSTALLER_DIR
echo "Settings PATH for terminal"
if hash gsettings 2>/dev/null; then
  gsettings set org.gnome.desktop.default-applications.terminal exec st
fi
if hash i3 2>/dev/null; then
  echo "bindsym \$mod+Return exec st" >> $HOME/.config/i3/config
fi
echo "export TERMINAL=st" >> $HOME/.profile
echo "Settings Default Shell to ZSH"
chsh -s $(whereis zsh | cut -d' ' -f2)
cp $STUBBE_INSTALLER_DIR/config/zsh/.zshrc $HOME/.stubbe/config/.zshrc
cp $STUBBE_INSTALLER_DIR/config/aliases/.aliasrc $HOME/.stubbe/config/.aliasrc
echo "Installing TMUX Plugin Manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
cp $STUBBE_INSTALLER_DIR/config/tmux/.tmux.conf $HOME/.stubbe/config/.tmux.conf
echo "Aliases for Terminal Added"
echo "st_config to open the terminal config"
echo "st_build to recompile the terminal after changing config"
echo "alias st_config='$EDITOR $HOME/.stubbe/builds/st/config.h'" >> $HOME/.stubbe/config/.aliasrc
echo "alias st_build='cd $HOME/.stubbe/builds/st && sudo make clean install && cd $HOME && echo reopen terminal!'" >> $HOME/.stubbe/config/.aliasrc
echo "Creating Symlinks"
ln -s $HOME/.stubbe/config/.zshrc $HOME/.zshrc
ln -s $HOME/.stubbe/config/.aliasrc $HOME/.aliasrc
ln -s $HOME/.stubbe/config/.tmux.conf $HOME/.tmux.conf
echo "Installing NvChad config to NeoVim"
git clone https://github.com/NvChad/NvChad $HOME/.config/nvim --depth 1 && nvim
