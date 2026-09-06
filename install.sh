#!/bin/sh
set -e
set -u

PACKAGES="git gh zsh curl fastfetch btop ffmpeg fzf lazygit"

# Detect package manager and install
if command -v dnf >/dev/null 2>&1; then
  # shellcheck disable=SC2086
  sudo dnf install -y $PACKAGES --exclude=lazygit
  sudo dnf copr enable -y dejan/lazygit
  sudo dnf install -y lazygit
elif command -v apt >/dev/null 2>&1; then
  sudo apt update
  # shellcheck disable=SC2086
  sudo apt install -y $PACKAGES
else
  echo "Unsupported package manager. Install manually: $PACKAGES"
  exit 1
fi

# Install oh-my-zsh if not already installed
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install mise
if ! command -v mise &>/dev/null; then
  curl https://mise.run | sh
fi

if [ -d ~/.dotfiles ]; then
  printf "The ~/.dotfiles directory already exists. Do you want to replace it? (y/n) "
  read -r choice
  case "$choice" in
  y | Y) rm -rf ~/.dotfiles ;;
  n | N) exit 1 ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
  esac
fi

# Initialize dotfiles repository
git clone https://github.com/solumath/.dotfiles.git ~/.dotfiles
git -C ~/.dotfiles submodule update --init --recursive

# Install fonts
mkdir -p ~/.local/share/fonts
ln -sf $(realpath ~/.dotfiles/fonts/MesloNerdFont) ~/.local/share/fonts/MesloNerdFont
fc-cache -f ~/.local/share/fonts

mkdir -p ~/.config/lazygit
ln -sf $(realpath ~/.dotfiles/lazygit/config.yml) ~/.config/lazygit/config.yml
ln -sf $(realpath ~/.dotfiles/git/.gitconfig) ~/.gitconfig
ln -sf $(realpath ~/.dotfiles/git/.gitignore_global) ~/.gitignore_global
ln -sf $(realpath ~/.dotfiles/zsh/.zshrc) ~/.zshrc
ln -sf $(realpath ~/.dotfiles/zsh/.p10k.zsh) ~/.p10k.zsh

# Need to remove the existing config directory before linking to the new one
rm -rf ~/.config/nvim
ln -sf $(realpath ~/.dotfiles/nvim/) ~/.config/nvim
rm -rf ~/.local/share/konsole
ln -sf $(realpath ~/.dotfiles/konsole/) ~/.local/share/konsole

# Add SSH keys, make sure to have correct permissions on ~/.ssh and ~/.ssh/authorized_keys
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

# Copy only if the key is not already present in the authorized_keys file
for key in $(curl -s https://github.com/solumath.keys) $(curl -s https://github.com/dfajmon.keys); do
  grep -qxF "$key" ~/.ssh/authorized_keys || echo "$key" >>~/.ssh/authorized_keys
done

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

printf "Done! Run \e[32mexec zsh\e[0m to apply changes.\n"
