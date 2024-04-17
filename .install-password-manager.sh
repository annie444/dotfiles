#!/usr/bin/env bash

export PWDIR="$HOME/.local/share/chezmoi"

unlock_op() {
  eval "$($OP_PATH signin)"
  sleep 2
  eval "$($OP_PATH signin)"
  eval "$OP_PATH read op://Dev/age\ key/key.txt >> ~/key.txt"
}

gotonext() {
  unlock_op
  bash "$PWDIR/.encryption.sh"
}

opmenu() {
  echo "Press w to wait for the 1Password GUI to be setup before continuing"
  echo "Press n to setup 1Password with the CLI"
  echo "Press x to exit"
  read -n 1 -p "Input Selection:" opmenuinput

  case "$opmenuinput" in
    "n")
      ;;
    "w")
      echo ""
      echo ""
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
      clear
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      clear
      opmenu
      ;;
  esac
  gotonext
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

install_op() {
  case "$(uname -s)" in
    Darwin)
       
      # Install xcode cli tools
      if [ $(xcode-select -p 1>/dev/null;echo $?) -ge 1 ]; then 
        xcode-select --install
      fi

      # Install Homebrew
      if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      
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

      find_shell "${HOMEBREW_ON_LINUX:-''}"

      echo 'eval "\$($HOMEBREW_PREFIX/bin/brew shellenv)"' >> ${SHELL_RCFILE}
      eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

      if ! command -v op &> /dev/null; then
        brew install --cask 1password
        brew install 1password-cli
      fi

      export OP_PATH="$HOMEBREW_PREFIX/bin/op"
      type op >/dev/null 2>&1 || echo "export PATH=\$PATH:$OP_PATH" >> ${SHELL_RCFILE}

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

      if [[ -v PACKAGE_MANAGER && -z $PACKAGE_MANAGER ]]; then
          . /etc/os-release
          case $ID in
            "rhel" | "fedora" | rhel | fedora)
              export PACKAGE_MANAGER="dnf"
              ;;
            "ubuntu" | "debian" | "mint" | "pop" | "raspbian" | "kali" | ubuntu | debian | mint | pop | raspbian | kali)
              export PACKAGE_MANAGER="apt"
              ;;
            *)
              echo "Unable to determine your package manager"
	            exit 2
	            ;;
	        esac
      fi

      declare -u DEB_OR_RPM

      case $PACKAGE_MANAGER in
        "apt")
          sudo apt update
          sudo apt install -y build-essential
          sudo apt install -y make git wget unzip
          DEB_OR_RPM="DEB"
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
          DEB_OR_RPM="RPM"
          ;;
        "dnf")
          sudo dnf update
          sudo dnf groupinstall "Development Tools"
          sudo dnf install -y make git wget unzip
          DEB_OR_RPM="RPM"
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
          DEB_OR_RPM="RPM"
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

      case $DEB_OR_RPM in
        "DEB" | DEB)
          wget -O 1password-latest.deb https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
          bash -c "sudo $PACKAGE_MANAGER install -y $HOME/1password-latest.deb"
          ;;
        "RPM" | RPM)
          wget -O 1password-latest.rpm https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
          bash -c "sudo $PACKAGE_MANAGER install -y $HOME/1password-latest.rpm"
          ;;
      esac

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
      exit 0
      ;;
    "x" | "X" | X | x)
      exit 1
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
  if command -v op; then
    clear
    echo "It appears the 1Password CLI tools are already installed"
    echo "Would you like to install them again?"
    echo ""
    read -n 1 -p "[Y]es | [N]o | [S]top [A]sking) " continuestatus

    case "$continuestatus" in
      "Y" | "y" | Y | y)
        declare -g SHELL_RCFILE=""
        declare -g OP_PATH=""
        install_op
        ;;
      "N" | "n" | N | n)
        check_again
        ;;
      "S" | "s" | S | s | "A" | "a" | A | a)
        echo "STOP" > "${PWDIR}/.store"
        exit 0
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
    install_op
  fi
}

if [ ! -f "$PWDIR/.store" ]; then
  check_status
fi
