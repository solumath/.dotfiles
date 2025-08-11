# .dotfiles

My personal dotfiles. For new machines to have my environment set up fast and hassle free.
Works by creating symlinks and placing them in $HOME.

## Prerequisites

Before installing, make sure to install `git`, `zsh`, and `oh-my-zsh`.

```bash
sudo apt install git zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installation

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/solumath/.dotfiles/main/install.sh)"
```

## Updating

Update as normal git repository.

### Pull changes

```bash
git pull
```

### Commit changes

```bash
git add .
git commit -m "Update dotfiles"
```
