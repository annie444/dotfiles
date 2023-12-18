#!/bin/bash

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

declare -g shell_rcfile=""

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
  case "${SHELL}" in
    */bash*)
      if [[ -n "${passed_str-}" ]]
      then
        shell_rcfile="${HOME}/.bashrc"
      else
        shell_rcfile="${HOME}/.bash_profile"
      fi
      ;;
    */zsh*)
      if [[ -n "${passed_str-}" ]]
      then
        shell_rcfile="${ZDOTDIR:-"${HOME}"}/.zshrc"
      else
        shell_rcfile="${ZDOTDIR:-"${HOME}"}/.zprofile"
      fi
      ;;
    */fish*)
      shell_rcfile="${HOME}/.config/fish/config.fish"
      ;;
    *)
      shell_rcfile="${ENV:-"${HOME}/.profile"}"
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
      HOMEBREW_PREFIX="/opt/homebrew"
      HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
    else
      # On Intel macOS, this script installs to /usr/local only
      HOMEBREW_PREFIX="/usr/local"
      HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
    fi

    find_shell "${HOMEBREW_ON_LINUX}"

    echo 'eval "\$($HOMEBREW_PREFIX/bin/brew shellenv)"' >> ${shell_rcfile}
    eval $($HOMEBREW_PREFIX/bin/brew shellenv)
    
    brew install --cask 1password
    brew install 1password-cli

    opmenu
    ;;
  Linux)
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

    type op >/dev/null 2>&1 || echo "export PATH=\$PATH:/usr/local/bin" >> ${shell_rcfile}

    opmenu
    ;;
  *)
    echo "unsupported OS"
    exit 1
    ;;
esac
