#!/usr/bin/env fish

function install
  set -f c $argv
  echo "Installing $c"
  if eval "brew install --cask $c"
    echo "Installed $c"
  else
    echo "$c failed to install. Trying again"
    set -f brewFailed "$c"
    set -f format $(echo "$brewFailed" | sed 's/[-_]/ /g')
    set -fa masArr (mas search "$format" | grep -wi "$format" | awk 'BEGIN{/([0-9]*)/} { printf "%u ", $1 }' | string split " ")
    if test (count $masArr) -le 3
      remove_file $brewFailed
    else
      remove_mas $masArr
    end 
    if not eval "brew install --cask $brewFailed"
      echo "$brewFailed failed to install. Please manually intervene."
      exit 1
    end
    echo "Installed $brewFailed"
  end
end

function remove_mas
  set -f masArr $argv
  for app in masArr
    echo "Uninstalling app $app"
    if eval "mas uninstall $app"
      echo "Uninstalled $app"
    else
      set -f appName (mas search $app | awk 'match($0, /[0-9]*\s*([0-9A-Za-z ]*)/) { print $2 }')
      echo "Found $appName"
      set -f file (sudo find /Applications -name "*$appName*.app" -depth 1 | string split "\n")
      echo "Removing app files at $file"
      sudo rm -rf "$file"
    end
  end
end

function remove_file
  set -f brewFailed $argv
  echo "Removing app $brewFailed"
  set -f appName (brew info --cask $brewFailed | grep -A1 'Name' | sed -n 2p)
  echo "Found $appName"
  set -f file (sudo find /Applications -name "*$appName*.app" -depth 1)
  echo "Removing app files at $file"
  sudo rm -rf "$file"
end

function cask_install
  clear
  echo "Installing casks"
  echo ""
  for cask in $casks
    install $cask
  end
  conda init (basename "$SHELL")
  mamba install pynvim 
  echo ""
end

function general_package_install
  clear
  echo "Installing formulae..."
  echo ""
  for package in $packages
    eval "$INSTALL_COMMAND $package"
  end
  echo ""
end

function fonts_install
  clear
  echo "Installing fonts and extended typography"
  echo ""
  for font in $fonts
    brew install --cask "$font"
  end
  echo ""
end

function install_typography
  clear
  echo "Installing fonts and extended typography"
  echo ""
  mkdir -p ~/.local/share/fonts
  for font in $fonts
    if not test -d "$HOME/.local/share/fonts/$font"
      curl -fsSL -o "$HOME/.local/share/fonts/$font.tar.xz" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$font.tar.xz"
      mkdir "$HOME/.local/share/fonts/$font/"
      tar -xf "$HOME/.local/share/fonts/$font.tar.xz" -C "$HOME/.local/share/fonts/$font/"
      rm "$HOME/.local/share/fonts/$font.tar.xz"
    end
  end
  fc-cache -f -v
  echo ""
end

function mas_install
  clear
  set -l masref $argv
  for i in $masref
    mas install $i
  end
  echo ""
end

function install_flatpaks
  clear
  echo "Installing Flatpaks..."
  for pack in $flatpaks
    flatpak install flathub $pack
  end
  echo ""
end

function darwinmenu
  echo "Press s to install Safari Extensions"
  echo "Press o to install Apple's document suite"
  echo "Press u to install Utility apps"
  echo "Press e to install Email clients"
  echo "Press p to install Apple Pro apps"
  echo "Press a to install Affinity Pro 2 apps"
  echo "Press m to install Messenger"
  echo "Press c to install Homebrew Cask apps"
  echo "Press f to install Homebrew formulae"
  echo "Press t to install typography"
  echo "Press r to install everything" 
  echo "Press n to continue to the next step"
  echo "Press x to exit"
  read -n 1 -P "Input Selection:" darwinmenuinput

  switch $darwinmenuinput
    case t
      fonts_install
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case f
      general_package_install 
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case c
      cask_install
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case s
      mas_install $masSafari
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case o
      mas_install $masDocs
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case u
      mas_install $masUtilities
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case e
      mas_install $masEmail
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case p
      mas_install $masApplePro
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case a
      mas_install $masDesign
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case m
      mas_install $masMessenger
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case r
      cask_install 
      mas_install $masSafari
      mas_install $masDocs
      mas_install $masUtilities
      mas_install $masEmail
      mas_install $masApplePro
      mas_install $masDesign
      mas_install $masMessenger
      general_package_install 
      fonts_install
      echo "Done!"
      sleep 2
      clear
      darwinmenu
    case x
      exit 1
    case n
      echo ""
    case '*'
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      clear
      darwinmenu
  end
end

function linuxmenu
  echo "Press f to install Flatpaks"
  echo "Press p to install Packages"
  echo "Press e to install Email clients"
  echo "Press t to install typography"
  echo "Press r to install everything" 
  echo "Press n to continue to the next step"
  echo "Press x to exit"
  read -n 1 -P "Input Selection:" linuxmenuinput

  switch $linuxmenuinput
    case f
      install_flatpaks
      echo "Done!"
      sleep 2
      clear
      linuxmenu
    case t
      install_typography
      echo "Done!"
      sleep 2
      clear
      linuxmenu
    case p 
      general_package_install 
      echo "Done!"
      sleep 2
      clear
      linuxmenu
    case r
      general_package_install 
      install_typography 
      install_flatpaks
      echo "Done!"
      sleep 2
      clear
      linuxmenu
    case x
      exit 1
    case n
      echo ""
    case '*'
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      clear
      linuxmenu
  end
end
