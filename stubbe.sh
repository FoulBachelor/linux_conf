#!/bin/bash
echo "Welcome to the STUBBE config Utility     "
echo "-----------------------------------------"
echo "1. add alias"
echo "2. edit .aliasrc"
echo "3. add zsh source"
echo "4. edit .zshrc"
echo "5. edit .tmux.conf"
echo "6. edit st config.h"
echo "7. update from master"
read -p "Please enter the option you want by number:" resp
case $resp in
  1)
    read -p "alias name:" alias_name
    read -p "alias execution:" alias_exec
    grep -v "$alias_name" $HOME/.stubbe/config/.aliasrc > tmpfile && mv tmpfile $HOME/.stubbe/config/.aliasrc
    echo "alias $alias_name=\"$alias_exec\"" >> $HOME/.stubbe/config/.aliasrc
    ;;
  2)
    exec $EDITOR $HOME/.stubbe/config/.aliasrc
    ;;
  3)
    read -p "absolute path to .zsh file:" zsh_name
    if test -f "$zsh_name"; then
        echo "if test -f '$zsh_name'; then source $zsh_name fi"
        echo "Import added to .zshrc";
        source $HOME/.stubbe/config/.aliasrc
      else
        echo "File didn't exist, therefore not added"
    fi
    ;;
  4)
    exec $EDITOR $HOME/.stubbe/config/.zshrc
    ;;
  5)
    exec $EDITOR $HOME/.stubbe/config/.tmux.conf
    ;;
  6)
    exec $EDITOR $HOME/.stubbe/builds/st/config.h
    ;;
  7)
    echo "This will overwrite your existing config for the following files"
    echo "1. $HOME/.stubbe/config/.aliasrc"
    echo "2. $HOME/.stubbe/config/.zshrc"
    echo "3. $HOME/.stubbe/config/.tmux.conf"
    echo "4. $HOME/.stubbe/builds/st/config.h"
    echo "5. All of the above!"
    read -p "Enter which file you would like to update:" upd_opt
    if [[ "$upd_opt" = "1" || "$upd_opt" = "5" ]]; then
      sudo wget -O https://raw.githubusercontent.com/FoulBachelor/linux_conf/main/config/aliases/.aliasrc -P $HOME/.stubbe/config/.aliasrc
    fi
    if [[ "$upd_opt" = "2" || "$upd_opt" = "5" ]]; then
      sudo wget -O https://raw.githubusercontent.com/FoulBachelor/linux_conf/main/config/zsh/.zshrc -P $HOME/.stubbe/config/.zshrc
    fi
    if [[ "$upd_opt" = "3" || "$upd_opt" = "5" ]]; then
      sudo wget -O https://raw.githubusercontent.com/FoulBachelor/linux_conf/main/config/tmux/.tmux.conf -P $HOME/.stubbe/config/.tmux.conf
    fi
    if [[ "$upd_opt" = "4" || "$upd_opt" = "5" ]]; then
      sudo wget -O https://raw.githubusercontent.com/FoulBachelor/linux_conf/main/config/st/config.h -P $HOME/.stubbe/config/.config.h
    fi
    ;;
esac
