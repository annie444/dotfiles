#!/usr/bin/env bash

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

declare -a casks

casks=("1password" "1password-cli" "anki" "arduino-ide" "balenaetcher" "breaktimer" "discord" "firefox" "fontforge" "google-chrome" "google-drive" "gpg-suite" "hex-fiend" "inkscape" "malwarebytes" "messenger" "nextcloud" "pastebot" "pocket-casts" "loopback" "postman" "qbittorrent" "mullvadvpn" "signal" "spotify" "steam" "tor-browser" "transmit" "vlc" "zoom" "libreoffice" "kitty" "slack" "docker" "julia" "mambaforge")

function install() {
  c=$1
  echo "Installing $c"
  if brew install --cask $c; then
    echo "Installed $c"
  else
    echo "$c failed to install. Trying again"
    brewFailed=$c
    declare -a masArr
    format=$(echo "$brewFailed" | sed 's/[-_]/ /g')
    masArr+=($(mas search "$format" | grep -wi '$format' | awk 'BEGIN{/([0-9]*)/} { printf "%u ", $1 }'))
    if [ "${#masArr[@]}" -le 3 ]; then
      remove_file $brewFailed
    else
      remove_mas $masArr
    fi
    brew install --cask $brewFailed || echo "$brewFailed failed to install. Please manually intervene."
    echo "Installed $brewFailed"
  fi
}

function remove_mas() {
  masArr=("$@")
  for app in "${masArr[@]}"; do
    echo "Uninstalling app $app"
    if mas uninstall $app; then
      echo "Uninstalled $app"
    else
      appName="$(mas search $app | awk 'match($0, /[0-9]*\s*([0-9A-Za-z ]*)/) { print $2 }')"
      echo "Found $appName"
      file="$(sudo find /Applications -name "*$name*.app" -depth 1)"
      echo "Removing app files at $file"
      sudo rm -rf "$file"
    fi
  done
}

function remove_file() {
  brewFailed=$1
  echo "Removing app $brewFailed"
  appName="$(brew info --cask $brewFailed | grep -A1 'Name' | sed -n 2p)"
  echo "Found $appName"
  file="$(sudo find /Applications -name "*$appName*.app" -depth 1)"
  echo "Removing app files at $file"
  sudo rm -rf "$file"
}

cask_install() {
  clear
  echo "Installing casks"
  echo ""
  for cask in "${casks[@]}"; do
    install $cask
  done
  conda init "$(basename "${SHELL}")"
  mamba install pynvim 
  echo ""
}

declare -a formulae

formulae=("node" "bat" "htop" "bandwhich" "bfs" "browsh" "bottom" "btop" "cheat" "browsh" "cheat" "curl" "dooit" "eza" "fd" "fzf" "fzy" "gawk" "gh" "git" "hyperfine" "iftop" "mosh" "most" "neofetch" "nmap" "webp" "notcurses" "parallel" "ripgrep" "rsync" "tealdeer" "thefuck" "tmux" "tree" "unar" "vivid" "wget" "xz" "boost-mpi" "openblas" "hdf5" "imagemagick" "gnuplot" "graphviz" "vtk" "spotify-tui" "armadillo" "dlib" "gsl" "pango" "ncurses" "cmake" "opencv" "thrift" "lazydocker" "dive" "cloc" "ruby" "cargo-udeps" "ghostscript" "jq" "deja-gnu" "flex" "mpfr" "autogen" "isl" "libffi" "zlib" "libxcrypt" "texinfo" "bison" "prettierd" "pkg-config" "lua-language-server" "marksman" "perl" "coursier" "scala" "php" "tetex" "terraform" "typescript" "certbot" "git-extras" "grpcurl" "helm" "kubectx" "kubernetes-cli" "kustomize" "lazygit" "mkcert" "sampler" "subversion" "upx" "wireguard-go" "chromedriver" "powershell" "ninja" "sqlite" "poetry" "ruff" "mercurial" "tree-sitter" "gzip" "gofumpt" "go" "m-cli" "neovim" "starship")

formula_install() {
  clear
  echo "Installing formulae..."
  echo ""
  brew tap browsh-org/homebrew-browsh
  for formula in "${formulae[@]}"; do
    brew install "$formula"
  done
  echo ""
}

declare -a fonts

fonts=("font-meslo-lg-nerd-font" "font-mononoki-nerd-font" "font-fira-code-nerd-font" "font-fira-mono-nerd-font" "font-iosevka-nerd-font" "font-hurmit-nerd-font" "font-ubuntu-nerd-font" "font-hack-nerd-font" "font-ubuntu-mono-nerd-font" "font-inconsolata-nerd-font" "font-envy-code-r-nerd-font" "font-martian-nerd-font" "font-terminess-ttf-nerd-font" "font-jetbrains-mono-nerd-font" "font-fantasque-sans-mono-nerd-font")

fonts_install() {
  clear
  echo "Installing fonts and extended typography"
  echo ""
  brew tap homebrew/cask-fonts
  for font in "${fonts[@]}"; do
    brew install --cask "$font"
  done
  echo ""
}

declare -A masSafari
declare -A masDocs
declare -A masUtilities
declare -A masEmail
declare -A masApplePro
declare -A masDesign
declare -A masMessenger

masSafari[1569813296]="1Password for Safari"
masSafari[1459809092]="Accelerate for Safari"
masDocs[409183694]="Keynote"
masDocs[409203825]="Numbers"
masDocs[409201541]="Pages"
masSafari[1365531024]="1Blocker - Ad Blocker"
masSafari[1568262835]="Super Agent for Safari"
masUtilities[441258766]="Magnet"
masEmail[1176895641]="Spark Classic – Email App"
masDesign[1616822987]="Affinity Photo 2"
masDesign[1616831348]="Affinity Designer 2"
masDesign[1606941598]="Affinity Publisher 2"
masApplePro[434290957]="Motion"
masApplePro[634148309]="Logic Pro"
masApplePro[424389933]="Final Cut Pro"
masApplePro[634159523]="MainStage"
masApplePro[424390742]="Compressor"
masEmail[1615488683]="Skiff Desktop - Work Privately"
masSafari[1160374471]="PiPifier"
masUtilities[937984704]="Amphetamine"
masMessenger[1480068668]="Messenger"

mas_install() {
  local -n mas_ref=$1
  local mas_title="$2"
  clear
  echo "Installing ${mas_title}"
  echo ""
  for i in "${!mas_ref[@]}"; do
    echo "Installing: ${mas_ref[$i]}"
    mas install $i
  done
  echo ""
}

install_bartender() {
  clear
  echo "Installing Bartender 5..."
  curl -fsSL -o ~/Downloads/Bartender.dmg https://www.macbartender.com/B2/updates/B5Latest/Bartender%205.dmg
  open ~/Downloads/Bartender.dmg
  sleep 2
  sudo cp -R /Volumes/Bartender\ 5/Bartender\ 5.app /Applications/
  echo ""
}

install_rust() {
  clear
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  echo ""
}

install_bun() {
  clear
  echo "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  echo ""
}

install_pnpm() {
  clear
  echo "Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  echo ""
}

masmenu() {

  echo "Press s to install Safari Extensions"
  echo "Press o to install Apple's document suite"
  echo "Press u to install Utility apps"
  echo "Press e to install Email clients"
  echo "Press p to install Apple Pro apps"
  echo "Press a to install Affinity Pro 2 apps"
  echo "Press m to install Messenger"
  echo "Press c to install Homebrew Cask apps"
  echo "Press f to install Homebrew formulae"
  echo "Press b to install Bartender"
  echo "Press t to install typography"
  echo "Press k to install pnpm"
  echo "Press j to install Bun JS"
  echo "Press d to install Rust"
  echo "Press r to install everything" 
  echo "Press n to continue to the next step"
  echo "Press x to exit"
  read -n 1 -p "Input Selection:" masmenuinput

  case "$masmenuinput" in
    "k")
      install_pnpm
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "j")
      install_bun
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "d")
      install_rust
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "t")
      fonts_install
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;; 
    "f")
      formula_install
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "b")
      install_bartender
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "c")
      cask_install
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "s")
      mas_install masSafari "Safari Extensions"
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "o")
      mas_install masDocs "Apple's Document Editor suite"
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "u")
      mas_install masUtilities "utility and productivity apps"
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "e")
      mas_install masEmail "email apps"
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "p")
      mas_install masApplePro "Apple Pro suite of apps"
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "a")
      mas_install masDesign "Affinity Pro 2 apps"
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "m")
      mas_install masMessenger "Facebook Messenger" 
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "r")
      cask_install 
      mas_install masSafari "Safari Extensions"
      mas_install masDocs "Apple's Document Editor suite"
      mas_install masUtilities "utility and productivity apps"
      mas_install masEmail "email apps"
      mas_install masApplePro "Apple Pro suite of apps"
      mas_install masDesign "Affinity Pro 2 apps"
      mas_install masMessenger "Facebook Messenger"
      install_bartender
      formula_install
      fonts_install
      install_rust
      install_pnpm
      install_bun
      echo "Done!"
      sleep 2
      clear
      masmenu
      ;;
    "x")
      exit 1
      ;;
    "n")
      ;;
    *)
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      echo "Press any key to continue..."
      read -n 1
      clear
      masmenu
      ;;
  esac
}

masmenu
