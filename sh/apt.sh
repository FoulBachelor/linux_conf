#!/bin/bash
echo "Checking system for updates"
sudo apt update
sleep 3
echo "Installing Prerequisites"
sudo apt install -y cmake
sudo apt install -y pkg-config
sudo apt install -y libfreetype6-dev
sudo apt install -y libfontconfig1-dev
sudo apt install -y libxft-dev
sudo apt install -y libx11-dev
sudo apt install -y libxcb-xfixes0-dev
sudo apt install -y libxkbcommon-dev
sudo apt install -y python3
sudo apt install -y git-all
sudo apt install -y curl
sudo apt install -y wget
sudo apt install -y zip
sudo apt install -y tar
sudo apt install -y tmux
sudo apt install -y zsh
sudo apt install -y ripgrep
sudo apt install -y sshfs
sleep 3
echo "Checking updates post-install"
sudo apt update
sleep 3
sudo apt upgrade -y
sleep 3
echo "Removing Ghost Files, Spookieeeeee"
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
echo "Making Directories and .Profile"
mkdir -p $HOME/.stubbe/builds
mkdir -p $HOME/.stubbe/builds/nvim
mkdir -p $HOME/.stubbe/builds/st
mkdir -p $HOME/.stubbe/config
mkdir -p $HOME/.fonts
touch -a $HOME/.profile
echo "Downloading NeoVim, a newer version of Vim, a newer version of Vi, an older version of 5"
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf ./nvim-*.tar.gz
cp -rf  $STUBBE_INSTALLER_DIR/nvim-linux64/* $HOME/.stubbe/builds/nvim
sudo ln -s $HOME/.stubbe/builds/nvim/bin/nvim /usr/bin/nvim
echo "Installing JetBrainsMono Nerd Font"
curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d $HOME/.fonts
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