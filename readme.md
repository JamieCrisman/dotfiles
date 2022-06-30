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
