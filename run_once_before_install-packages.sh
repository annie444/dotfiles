#!/bin/bash
case "$(uname -s)" in
  Darwin)
    brew install age
    ;;
  Linux)
    declare -A osInfo;
    osInfo[/etc/debian_version]="apt-get"
    osInfo[/etc/alpine-release]="apk"
    osInfo[/etc/centos-release]="yum"
    osInfo[/etc/fedora-release]="dnf"
    osInfo[/etc/arch-release]="pacman"
    osInfo[/etc/gentoo-release]="emerge"
    osInfo[/etc/suse-release]="zypper"

    for f in ${!osInfo[@]}; do
        if [[ -f $f ]]; then
            package_manager=${osInfo[$f]}
        fi
    done

    case $package_manager in
      "apt-get")
        sudo apt-get install -y age
        ;;
      "apk")
        sudo apk --update add age
        ;;
      "yum")
        sudo yum install -y age
        ;;
      "dnf")
        sudo dnf install -y age
        ;;
      "pacman")
        sudo pacman -Sy age
        ;;
      "emerge")
        sudo emerge app-crypt/age
        ;;
      "zypper")
        sudo zypper install -y age
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

