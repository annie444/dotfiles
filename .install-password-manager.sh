#!/usr/bin/env bash

export PWDIR="$HOME/.local/share/chezmoi"

unlock_op() {
  eval "$(${OP_PATH:-op} signin)"
  sleep 2
  eval "$(${OP_PATH:-op} signin)"
  eval "${OP_PATH:-op} read op://Dev/age\ key/key.txt >> ~/key.txt"
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
  case "${SHELL}" in
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

install_op_asdf() {
  if [[ "${SHELL_RCFILE}" =~ (.*)fish ]]; then
    echo 'set -gx --prepend ASDF_DATA_DIR "$HOME/.asdf"' >> ${SHELL_RCFILE}
    echo 'set _asdf_shims "$ASDF_DATA_DIR/shims"' >> ${SHELL_RCFILE}
    echo 'if not contains $_asdf_shims $PATH' >> ${SHELL_RCFILE}
    echo '    set -gx --prepend PATH $_asdf_shims' >> ${SHELL_RCFILE}
    echo 'end' >> ${SHELL_RCFILE}
    echo 'set --erase _asdf_shims' >> ${SHELL_RCFILE}
  else
    echo 'export ASDF_DATA_DIR="$HOME/.asdf"' >> ${SHELL_RCFILE}
    echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> ${SHELL_RCFILE}
  fi
  export ASDF_DATA_DIR="$HOME/.asdf"
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

  asdf plugin add 1password-cli
  asdf install 1password-cli latest
  asdf set 1password-cli latest
  asdf reshim
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
        brew install asdf
        install_op_asdf
      fi

      OP_PATH="$(which op)"
      export OP_PATH

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
              export PACKAGE_MANAGER=${osInfo[$f]}
          fi
      done

      if [[ -z $PACKAGE_MANAGER && ${PACKAGE_MANAGER+x} ]]; then
          . /etc/os-release
          case $ID in
            "rhel" | "fedora" | "rocky" | "alma" | "centos" | rhel | fedora | rocky | alma | centos)
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
        apt)
          sudo apt update
          sudo apt install -y build-essential
          sudo apt install -y make git wget unzip jq curl tar gzip
          DEB_OR_RPM="DEB"
          ;;
        apk)
          apk update 
          apk add --no-cache build-basa
          apk add --no-cache git make wget unzip jq curl tar gzip
          ;;
        yum)
          sudo yum update
          sudo yum groupinstall "Development Tools"
          sudo yum install -y make git wget unzip jq curl tar gzip
          DEB_OR_RPM="RPM"
          ;;
        dnf)
          sudo dnf update
          sudo dnf groupinstall "Development Tools"
          sudo dnf install -y make git wget unzip jq curl tar gzip
          DEB_OR_RPM="RPM"
          ;;
        pacman)
          sudo pacman -Syyu
          sudo pacman -Sy base-devel
          sudo pacman -Sy make git wget unzip jq curl tar gzip
          ;;
        emerge)
          sudo emerge app-crypt/age 
          ;;
        zypper)
          sudo zypper refresh
          sudo zypper update
          sudo zypper install -t pattern devel_C_C++
          sudo zypper install make git wget unzip jq curl tar gzip
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
          export ARCH
          ;;
        aarch64)
          ARCH="arm64"
          export ARCH
          ;;
        * ) 
          ARCH=$cpu_arch
          export ARCH
          ;;
      esac

      ASDF_VERSION="$(curl -S https://api.github.com/repos/asdf-vm/asdf/releases/latest | jq -r '.tag_name')"

      wget "https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/asdf-${ASDF_VERSION}-linux-${ARCH}.tar.gz" -O asdf.tar.gz
      tar -xzf asdf.tar.gz
      chmod +x asdf
      sudo mv asdf /usr/bin/
      rm -f asdf.tar.gz

      find_shell

      install_op_asdf

      OP_PATH="$(which op)"
      export OP_PATH

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
