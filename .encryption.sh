#!/usr/bin/env bash

gotonext() {
  fish "$PWDIR/.install-packages.fish"
}

install_shell_brew() {
  if ! sudo grep -q "$(brew --prefix)/bin/fish" /etc/shells; then
    brew install fish
    echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(brew --prefix)/bin/zsh" /etc/shells; then
    brew install zsh
    echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(brew --prefix)/bin/bash" /etc/shells; then
    brew install bash
    echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
  fi

  if ! command -v mas &> /dev/null; then
    brew install mas
  fi

  softwareupdate --install-rosetta --agree-to-license

  if [[ ! "$SHELL" == "$(brew --prefix)/bin/fish" ]]; then
    chsh -s "$(brew --prefix)/bin/fish"
  fi
}

install_shell_apt() {
  if ! command -v fish &> /dev/null; then 
    sudo apt install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo apt install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo apt install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo apt install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_apk() {
  if ! command -v fish &> /dev/null; then
    apk add --no-cache fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo apk add --no-cache zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo apk add --no-cache bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo apk add --no-cache flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_yum() {
  if ! command -v fish &> /dev/null; then
    sudo yum install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo yum install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo yum install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo yum install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_dnf() {
  if ! command -v fish &> /dev/null; then
    sudo dnf install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo dnf install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo dnf install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo dnf install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_pacman() {
  if ! command -v fish &> /dev/null; then
    sudo pacman -Sy fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo pacman -Sy zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo pacman -Sy bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo pacman -Sy flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_emerge() {
  if ! command -v fish &> /dev/null; then
    sudo emerge sys-apps/fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo emerge sys-apps/zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo emerge sys-apps/bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    echo -e 'sys-apps/flatpak ~amd64\nacct-user/flatpak ~amd64\nacct-group/flatpak ~amd64\ndev-util/ostree ~amd64' | sudo tee -a /etc/portage/package.accept_keywords/flatpak
    sudo emerge sys-apps/flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_zypper() {
  if ! command -v fish &> /dev/null; then
    sudo zypper install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo zypper install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo zypper install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo zypper install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_age_and_shells() {
  case "$(uname -s)" in
    Darwin)
      eval "$(cat $PWDIR/darwin_defaults.sh)"
      eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
      brew install age
      install_shell_brew
      set_defaults_darwin 
      export INSTALL_COMMAND="brew install -y"
      gotonext
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

      gotonext
      ;;
    *)
      echo "Unsupported OS"
      exit 0
      ;;
  esac
}

check_again() {
  clear
  echo "Would you like to install any other programs?"
  echo "Press i to install other packages"
  echo "Press c to continue with chezmoi"
  echo "Press x to cancel"
  echo ""
  read -n 1 -p "Input your selection: " checkstat

  case "$checkstat" in
    "i" | "I" | i | I)
      gotonext
      ;;
    "c" | "C" | C | c)
      clear
      ;;
    "x" | "X" | X | x)
      exit
      ;;
    *)
      clear
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      check_again
      ;;
  esac
}

check_status() {
  if command -v age && command -v fish; then
    clear
    echo "It appears the encryption modules are already installed"
    echo "Would you like to install them again?"
    echo ""
    read -n 1 -p "(Y/N) " continuestatus

    case "$continuestatus" in
      "Y" | "y" | Y | y)
        install_age_and_shells
        ;;
      "N" | "n" | N | n)
        check_again
        ;;
      *)
        clear
        echo "You have entered an invallid selection!"
        echo "Please try again!"
        echo ""
        echo "Press any key to continue..."
        read -n 1
        check_status
        ;;
    esac
  else
    install_age_and_shells
  fi
}
