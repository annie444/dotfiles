#!/bin/bash

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

declare -g SHELL_RCFILE=""
declare -g OP_PATH=""

opmenu() {
  echo "Press `w` to wait for the 1Password GUI to be setup before continuing"
  echo "Press `n` to setup 1Password with the CLI"
  echo "Press `x` to exit"
  read -n 1 -p "Input Selection:" opmenuinput

  case "$opmenuinput" in
    "n")
      ;;
    "w")
      echo "Please log in to the 1Password application"
      echo "and turn on CLI integration"
      echo "(Settings > Developter > CLI)"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      ;;
    "x")
      exit 1
      ;;
    *)
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      clear
      opmenu
      ;;
  esac
}

find_shell() {
  passed_str="$1"
  case "${shell}" in
    */bash*)
      if [[ -n "${passed_str-}" ]]
      then
        export SHELL_RCFILE="${HOME}/.bashrc"
      else
        export SHELL_RCFILE="${HOME}/.bash_profile"
      fi
      ;;
    */zsh*)
      if [[ -n "${passed_str-}" ]]
      then
        export SHELL_RCFILE="${ZDOTDIR:-"${HOME}"}/.zshrc"
      else
        export SHELL_RCFILE="${ZDOTDIR:-"${HOME}"}/.zprofile"
      fi
      ;;
    */fish*)
      export SHELL_RCFILE="${HOME}/.config/fish/config.fish"
      ;;
    *)
      export SHELL_RCFILE="${env:-"${HOME}/.profile"}"
      ;;
  esac
}

case "$(uname -s)" in
  Darwin)
    # Install xcode cli tools
    xcode-select --install

    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


    UNAME_MACHINE="$(/usr/bin/uname -m)"
    if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
      # On ARM macOS, this script installs to /opt/homebrew only
      export HOMEBREW_PREFIX="/opt/homebrew"
      HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
    else
      # On Intel macOS, this script installs to /usr/local only
      export HOMEBREW_PREFIX="/usr/local"
      HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
    fi

    find_shell "${HOMEBREW_ON_LINUX}"

    echo 'eval "\$($HOMEBREW_PREFIX/bin/brew shellenv)"' >> ${SHELL_RCFILE}
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
    
    brew install --cask 1password
    brew install 1password-cli

    export OP_PATH="$HOMEBREW_PREFIX/bin/op"

    opmenu
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
            PACKAGE_MANAGER=${osInfo[$f]}
        fi
    done

    case $PACKAGE_MANAGER in
      "apt")
        sudo apt update
        sudo apt install -y build-essential
        sudo apt install -y make git wget unzip
        ;;
      "apk")
        apk update 
        apk add --no-cache build-basa
        apk add --no-cache git make wget unzip
        ;;
      "yum")
        sudo yum update
        sudo yum groupinstall "Development Tools"
        sudo yum install -y make git wget unzip
        ;;
      "dnf")
        sudo dnf update
        sudo dnf groupinstall "Development Tools"
        sudo dnf install -y make git wget unzip
        ;;
      "pacman")
        sudo pacman -Syyu
        sudo pacman -Sy base-devel
        sudo pacman -Sy make git wget unzip
        ;;
      "emerge")
        sudo emerge app-crypt/age
        ;;
      "zypper")
        sudo zypper refresh
        sudo zypper update
        sudo zypper install -t pattern devel_C_C++
        sudo zypper install make git wget unzip
        ;;
      *)
        echo "Unsupported OS"
        exit 0
        ;;
    esac
    
    # commands to install password-manager-binary on Linux
    cpu_arch=$(lscpu | grep -w "Architecture:" | awk 'END{/([a-zA-Z0-9_-]*)/} {print $2}')

    case $cpu_arch in
      x86_64)
        ARCH="amd64" 
        ;;
      * ) 
        ARCH=$cpu_arch
        ;;
    esac

    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.24.0/op_linux_${ARCH}_v2.24.0.zip" -O op.zip
    unzip -d op op.zip
    sudo mv op/op /usr/local/bin
    rm -r op.zip op
    sudo groupadd -f onepassword-cli
    sudo chgrp onepassword-cli /usr/local/bin/op
    sudo chmod g+s /usr/local/bin/op

    find_shell

    export OP_PATH="/usr/local/bin/op"

    type op >/dev/null 2>&1 || echo "export PATH=\$PATH:/usr/local/bin" >> ${SHELL_RCFILE}

    opmenu
    ;;
  *)
    echo "unsupported OS"
    exit 1
    ;;
esac
