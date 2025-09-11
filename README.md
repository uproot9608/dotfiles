# My dotfiles

This directory contains complete rework of the dotfiles for my system

## Requirements

Ensure you have git and stow installed on your system

## Mac

### Git
Cones preinstalled

### Stow

```
brew install stow
```

## Linux

### Git
```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, clone this repo using git

```
$ git clone git@github.com/uproot9608/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
