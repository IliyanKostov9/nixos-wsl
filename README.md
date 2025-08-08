# ❄️ NiOxS wsl ❄️

[![License](https://img.shields.io/github/license/IliyanKostov9/nixos-wsl)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Build Status: Flake](https://img.shields.io/github/actions/workflow/status/IliyanKostov9/nixos-wsl/flake-test.yml?branch=master)](https://github.com/IliyanKostov9/nixos-config/actions?query=branch%3Amaster)
[![GitGuardian scan](https://github.com/IliyanKostov9/nixos-wsl/actions/workflows/security-tests.yaml/badge.svg?branch=master)](https://github.com/IliyanKostov9/nixos-wsl/actions/workflows/security-tests.yaml)
[![Written in Nix](https://img.shields.io/badge/code-nix-blue)](https://nixos.org/)
[![NixOS Unstable](https://img.shields.io/badge/NixOS-25.05-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)
[![GitHub release](https://img.shields.io/github/v/release/IliyanKostov9/nixos-wsl)](#)
[![GitHub release date](https://img.shields.io/github/release-date/IliyanKostov9/nixos-wsl)](#)
[![GitHub last commit](https://img.shields.io/github/last-commit/IliyanKostov9/nixos-wsl)](#)
[![Free](https://img.shields.io/badge/free_for_non_commercial_use-brightgreen)](#-license)

:star: Star us on GitHub — it motivates us a lot!

## 🚀 About

> My personal NixOS WSL configuration file.
> <img src="./assets/nixos_image.png" align="right"/>

It contains software configurations for setting up my work machines.

## 🎉 Getting started

To get started, first run `make build` for the script to build your system and user (nixos) configurations.

## 🏝️ Environment

<details>
<summary>Structure details</summary>

| Type           | Program      |
| :------------- | :----------: |
| Editor         | [NeoVim](https://neovim.io/) |
| Shell          | [Zsh](https://ohmyz.sh/) |
| Terminal Font  | [OxProto Nerd Font](https://www.nerdfonts.com/font-downloads) |

</details>

## 🧪 Used Nix features 

1. home-manager
2. flakes
3. flake-parts

## 🏗️ Structure

```markdown
.
├── config
├── config.nix
├── flake.lock
├── flake.nix
├── flakes
├── home
├── hosts
├── Makefile
├── programs
└── shells
```

- **config**: Configuration for different applications (window managers for Windows 11 for example)
- **config.nix**: An attribute set, containing all of the user and host specific configuration, that is consumed by the home and hosts module
- **flake.lock**: auto generated file, when building the system along with an argument of `--flake`. Used for pinning down the specific versions of the Nix dependencies, that are listed under *flake.nix*
- **flake.nix**: file for declaring all of the Nix specific dependencies/features (flake-parts, home-manager, nixpkgs, etc.). It is also the entry point for importing the user/system flakes
- **flakes**: used for storing all of the modularized flakes, that is consumed by flake-parts
- **home**: used for storing all the user environments (Joe's PC, Jane's PC, etc.)
- **hosts**: used for storing the WSL types of the hosts machines
- **Makefile**: automation script for aliasing Nix CLI commands in a more user-friendly way
- **programs**: contains the user/system type of packages
- **shells**: bash files for different purposes (for tmux for example)

##  🧑‍💻 Commands

|Command|Description|
|:-|:-|
|make help|Show available commands with their description|
|make home-update|Build your home configuration|
|make sys-update|Build your system configuration|
|make flake-upgrade|Upgrade flake dependencies
|make flake-check|Validate flake.nix|
|make flake-meta|Output the flake input dependencies in a tree format|
|make clean|Remove system and user generations|

### 🌱 Setup 

<details><summary><b>Show instructions</b></summary>

  1. Build your system configuration

    make sys-update

  2. Build your user configuration

    make home-update

  Afterwards enter `config.nix` and change the values of the username to the ones you currently have.
</details>

## 🤝 Acknowledgments

This configuration structure was inspired by contributions from the Nix community:

- [wimpysworld](https://github.com/wimpysworld/nix-config)
- [ryan4yin](https://github.com/ryan4yin/nix-config)
- [simple-homemanager](https://github.com/evertras/simple-homemanager)
- [chayward1] (https://github.com/chayward1/dotfiles)
- [notusknot] (https://github.com/notusknot/dotfiles-nix/tree/main)

### 🔍️ References 

This section helped me better understand Nix package manager and Nix language.
Please have a read on them!

#### 📚 Docs
- [ Nixpills ]( https://nixos.org/guides/nix-pills )
- [ Nix and flakes ]( https://nixos-and-flakes.thiscute.world )
- [ Home manager manual ]( https://nix-community.github.io/home-manager/index.xhtml )
- [ Intro to Nix and NixOS ]( https://nixos-and-flakes.thiscute.world/introduction )

#### 📄 Package and template links
- [ Nixpkgs ](https://search.nixos.org/packages) 
- [ MyNixOS ](https://mynixos.com/nixpkgs )
- [ NixOS cache ]( https://cache.nixos.org )
- [ Flake parts ]( https://community.flake.parts )

### 📃 License
This product is licensed under [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.en.html)

