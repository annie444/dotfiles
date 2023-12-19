#!/usr/bin/env bash

eval "$OP_PATH signin"

eval "$OP_PATH read op://Dev/age\ key/key.txt >> ~/key.txt"

export PWDIR="$(pwd)"
eval "source $PWDIR/install_shells.sh"

case "$(uname -s)" in
  Darwin)
    source "$PWDIR/darwin_defaults.sh"
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
    brew install age
    install_shell_brew
    set_defaults_darwin 
    export INSTALL_COMMAND="brew install -y"
    ;;
  Linux)
    declare -A osInfo;
    osInfo[/etc/debian_version]="apt"
    osInfo[/etc/alpine-release]="apk"
    osInfo[/etc/centos-release]="yum"
    osInfo[/etc/fedora-release]="dnf"
    osInfo[/etc/arch-release]="pacman"
    osInfo[/etc/gentoo-release]="emerge"
    osInfo[/etc/suse-release]="zypper"

    for f in ${!osInfo[@]}; do
        if [[ -f $f ]]; then
            export PACKAGE_MANAGER=${osInfo[$f]}
        fi
    done

    case $PACKAGE_MANAGER in
      "apt")
        sudo apt update
        sudo apt install build-essential
        sudo apt install -y age
        install_shell_apt
        export INSTALL_COMMAND="sudo apt install -y"
        ;;
      "apk")
        apk update 
        apk add --no-cache build-base
        apk --update add age
        install_shell_apk
        export INSTALL_COMMAND="apk add --no-cache"
        ;;
      "yum")
        sudo yum update
        sudo yum groupinstall "Development Tools"
        sudo yum install -y age
        install_shell_yum
        export INSTALL_COMMAND="sudo yum install -y"
        ;;
      "dnf")
        sudo dnf update
        sudo dnf groupinstall "Development Tools"
        sudo dnf install -y age
        install_shell_yum
        export INSTALL_COMMAND="sudo dnf install -y"
        ;;
      "pacman")
        sudo pacman -Syyu
        sudo pacman -S base-devel
        sudo pacman -Sy age
        install_shell_pacman
        export INSTALL_COMMAND="sudo pacman -Sy"
        ;;
      "emerge")
        sudo emerge app-crypt/age
        install_shell_emerge
        ;;
      "zypper")
        sudo zypper refresh
        sudo zypper update
        sudo zypper install -t pattern devel_C_C++
        sudo zypper install -y age
        install_shell_zypper
        export INSTALL_COMMAND="sudo zypper install -y"
        ;;
      *)
        echo "Unsupported OS"
        exit 0
        ;;
    esac
    ;;
  *)
    echo "Unsupported OS"
    exit 0
    ;;
esac

fish "$PWDIR/install_packages.fish"
