# Dotfiles


checkout + link with stow

```
sudo apt install stow
brew install stow
```

checking out this repo from ~
cd into dotfiles and run

```
stow nvim
stow kitty
stow ...etc
```

Rust debugging

The debugger is configured to use a binary that's distributed with vscode extension: [codelldb](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)

It has a default location it will try to look at, but you can specify a new path in the `RUSTLLDB_PATH` environment variable 


## Zsh stuff

The .zshrc will source a `~/system-specific.sh` for setting up envs and stuff that might not be used on other machines

### Oh My Zsh

can install with

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

or [check the repo for latest instructions](https://github.com/ohmyzsh/ohmyzsh)


### Programs to get

- [tmux](https://github.com/tmux/tmux)
  - [cheat sheet](https://gist.github.com/MohamedAlaa/2961058)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [bat](https://github.com/sharkdp/bat)
- [exa](https://github.com/ogham/exa)
