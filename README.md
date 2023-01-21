# Pro Vim dotfiles

Example configuration for Vim, NeoVim and other associated utilities for [Про Vim](https://habr.com/ru/post/706402/) article series

## Prerequisites

Minimal environment for core configs:

 - POSIX OS and shell
 - Terminal emulator
 - Vim >= 8

Standard environment for configs to work as expected:

- Linux with bash/zsh default shell
- High color teminal emulator
- Vim >=8.2 (+keymap, +clipboard, +mouse, +syntax, +wildmenu, ...)
- NeoVim >= 8.1 LuaJIT 2.1.0-beta3
- Python3 >= 3.10.6 (pip, pynvim...)
- Node.js >= 18.12.1 (npm, yarn...)
- fzf >= 0.29
- etc.


## Installation

Just copy selected lines in your own config or fork all configs to your GitHub profile and clone it to your linux home dir and run `vim`.

## Vim

Main configuration in `.vimrc` keeps general defaults no matter the other environment. A properly installed Vim higher than v8 with standard option set should support all configuration options.

Optional configuration which depend on other plugins and third party software reside in `.vim/` directory. It is essentialy safe not to use it at all on limited environments.

# NeoVim

NeoVim should also fully support `.vimrc` commands unless `Lua` configuration is explicitly enabled.

TODO: Add NeoVim specific configs

## Bash

A standard `.bashrc` just as an example of how to add some useful system aliases and params to your Vim environment

## Zsh

TODO: Add zsh minimal config

## Git

An example of how to use git on a home directory to syncronize your environment configurations between your accounts. Main trick is to put a star `*` in first line of `.gitignore` file to get explicite control on what to sync.

## Tmux

TODO: Add tmux related configs

## Alacritty

TODO: Add Alacritty related configs

## Konsole

TODO: Add konsole related configs

## XTerm

TODO: Add xterm related configs
