#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

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

    case "${SHELL}" in
      */bash*)
        if [[ -n "${HOMEBREW_ON_LINUX-}" ]]
        then
          shell_rcfile="${HOME}/.bashrc"
        else
          shell_rcfile="${HOME}/.bash_profile"
        fi
        ;;
      */zsh*)
        if [[ -n "${HOMEBREW_ON_LINUX-}" ]]
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

    echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ${shell_rcfile}
    eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)
    
    brew install --cask 1password
    brew install 1password-cli
    op signin

    op read op://Dev/age\ key/key.txt > ~/key.txt
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

    op signin

    op read op://Dev/age\ key/key.txt > ~/key.txt
    ;;
  *)
    echo "unsupported OS"
    exit 1
    ;;
esac
