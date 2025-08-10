#!/bin/bash
set -e
set -u

if [ -d ~/.dotfiles ]; then
    read -p "The ~/.dotfiles directory already exists. Do you want to replace it? (y/n) " choice
    case "$choice" in
        y|Y ) rm -rf ~/.dotfiles ;;
        n|N ) exit 1 ;;
        * ) echo "Invalid choice. Exiting." ; exit 1 ;;
    esac
fi

git clone https://github.com/solumath/.dotfiles.git ~/.dotfiles

if [ -d ~/solumath ]; then
    ln -sf $(realpath ~/.dotfiles/git/.gitconfig_solumath) ~/solumath/
fi

if [ -d ~/openshift ]; then
    ln -sf $(realpath ~/.dotfiles/git/.gitconfig_dfajmon) ~/openshift/
fi

if [ -d ~/kubernetes ]; then
    ln -sf $(realpath ~/.dotfiles/git/.gitconfig_dfajmon) ~/kubernetes/
fi

ln -sf $(realpath ~/.dotfiles/git/.gitconfig) ~/.gitconfig
ln -sf $(realpath ~/.dotfiles/zsh/.zshrc) ~/.zshrc
ln -sf $(realpath ~/.dotfiles/zsh/.p10k.zsh) ~/.p10k.zsh

# remove folder before linking it
rm -rf ~/.oh-my-zsh/custom
ln -sf $(realpath ~/.dotfiles/zsh/custom/) ~/.oh-my-zsh/

# Initialize plugins and themes
cd ~/.dotfiles
git submodule update --init --recursive

# Add SSH keys
mkdir -p ~/.ssh
curl https://github.com/solumath.keys | tee -a ~/.ssh/authorized_keys
curl https://github.com/dfajmon.keys | tee -a ~/.ssh/authorized_keys
