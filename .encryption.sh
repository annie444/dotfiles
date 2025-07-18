#!/usr/bin/env bash

gotonext() {
  echo "Done!"
  exit 0
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo apt install zsh
    which zsh | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo apt install bash 
    which bash | sudo tee -a /etc/shells
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo apk add --no-cache zsh
    which zsh | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo apk add --no-cache bash 
    which bash | sudo tee -a /etc/shells
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo yum install zsh
    which zsh | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo yum install bash 
    which bash | sudo tee -a /etc/shells
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo dnf install zsh
    which zhs | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo dnf install bash 
    which bash | sudo tee -a /etc/shells
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo pacman -Sy zsh
    which zhs | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo pacman -Sy bash 
    which bash | sudo tee -a /etc/shells
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo emerge sys-apps/zsh
    which zhs | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo emerge sys-apps/bash 
    which bash | sudo tee -a /etc/shells
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
    which fish | sudo tee -a /etc/shells
  fi

  if ! command -v zsh &> /dev/null; then
    sudo zypper install zsh
    which zsh | sudo tee -a /etc/shells
  fi

  if ! command -v bash &> /dev/null; then
    sudo zypper install bash 
    which bash | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo zypper install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

asdf_age() {
  asdf plugin add age
  asdf plugin add age-plugin-yubikey
  asdf install age latest
  asdf install age-plugin-yubikey latest
  asdf set age latest
  asdf set age-plugin-yubikey latest
}

install_age_and_shells() {
  case "$(uname -s)" in
    Darwin)
      source "${PWDIR}/.macos-settings.sh"
      source "${PWDIR}/.finder-defaults.sh"
      eval "$("${HOMEBREW_PREFIX:-/opt/homebrew}/bin/brew" shellenv)"

      asdf_age

      if ! echo "$SHELL" | grep -q fish; then
        install_shell_brew
      fi
      export INSTALL_COMMAND="brew install"

      gotonext
      ;;

    Linux)
      asdf_age

      declare -A osInfo;
      osInfo[/etc/debian_version]="apt"
      osInfo[/etc/alpine-release]="apk"
      osInfo[/etc/centos-release]="yum"
      osInfo[/etc/fedora-release]="dnf"
      osInfo[/etc/arch-release]="pacman"
      osInfo[/etc/gentoo-release]="emerge"
      osInfo[/etc/suse-release]="zypper"

      for f in "${!osInfo[@]}"; do
          if [[ -f $f ]]; then
              export PACKAGE_MANAGER=${osInfo[$f]}
          fi
      done

      if [[ -v PACKAGE_MANAGER && -z $PACKAGE_MANAGER ]]; then
          . /etc/os-release
          case $ID in
            "rhel" | "fedora")
              export PACKAGE_MANAGER="dnf"
              ;;
            "ubuntu" | "debian" | "mint" | "pop" | "raspbian" | "kali")
              export PACKAGE_MANAGER="apt"
              ;;
            *)
              echo "Unable to determine your package manager"
	            exit 2
	            ;;
	        esac
      fi 



      case $PACKAGE_MANAGER in
        "apt")
          install_shell_apt
          export INSTALL_COMMAND="sudo apt install -y"
          ;;
        "apk")
          install_shell_apk
          export INSTALL_COMMAND="apk add --no-cache"
          ;;
        "yum")
          install_shell_yum
          export INSTALL_COMMAND="sudo yum install -y"
          ;;
        "dnf")
          install_shell_yum
          export INSTALL_COMMAND="sudo dnf install -y"
          ;;
        "pacman")
          install_shell_pacman
          export INSTALL_COMMAND="sudo pacman -Sy"
          ;;
        "emerge")
          install_shell_emerge
          ;;
        "zypper")
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
  echo "Press c to continue with chezmoi"
  echo "Press x to cancel"
  echo ""
  read -r -n 1 -p "Input your selection: " checkstat

  case "$checkstat" in
    "c" | "C")
      clear
      ;;
    "x" | "X")
      exit
      ;;
    *)
      clear
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -r -n 1
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
    read -r -n 1 -p "(Y/N) " continuestatus

    case "$continuestatus" in
      "Y" | "y")
        install_age_and_shells
        ;;
      "N" | "n")
        check_again
        ;;
      *)
        clear
        echo "You have entered an invallid selection!"
        echo "Please try again!"
        echo ""
        echo "Press any key to continue..."
        read -r -n 1
        check_status
        ;;
    esac
  else
    install_age_and_shells
  fi
}

check_status
