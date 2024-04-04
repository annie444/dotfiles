#!/usr/bin/env fish

source "$PWDIR/.install-utils.fish"

switch (uname -s)
  case Darwin
    fish_add_path "$HOMEBREW_PREFIX/bin"
    fish_add_path "$HOMEBREW_PREFIX/sbin"
    set -g casks 1password 1password-cli anki arduino-ide balenaetcher breaktimer discord firefox fontforge google-chrome google-drive gpg-suite hex-fiend inkscape malwarebytes messenger nextcloud pastebot pocket-casts loopback postman qbittorrent mullvadvpn signal spotify steam tor-browser transmit vlc zoom libreoffice kitty slack docker julia mambaforge cmake obsidian
    set -g packages node bat htop bandwhich bfs browsh bottom btop cheat browsh cheat curl dooit eza fd fzf fzy gawk gh git hyperfine iftop mosh most neofetch nmap webp notcurses parallel ripgrep rsync tealdeer thefuck tmux tree unar vivid wget xz boost-mpi openblas hdf5 imagemagick gnuplot graphviz vtk spotify-tui armadillo dlib gsl pango ncurses opencv thrift lazydocker dive cloc ruby cargo-udeps ghostscript jq deja-gnu flex mpfr autogen isl libffi zlib libxcrypt texinfo bison prettierd pkg-config lua-language-server marksman perl coursier scala php tetex terraform typescript certbot git-extras grpcurl helm kubectx kubernetes-cli kustomize lazygit mkcert sampler subversion upx wireguard-go chromedriver powershell ninja sqlite poetry ruff mercurial tree-sitter gzip gofumpt go m-cli neovim starship zoxide gnupg
    set -g fonts font-meslo-lg-nerd-font font-mononoki-nerd-font font-fira-code-nerd-font font-fira-mono-nerd-font font-iosevka-nerd-font font-hurmit-nerd-font font-ubuntu-nerd-font font-hack-nerd-font font-ubuntu-mono-nerd-font font-inconsolata-nerd-font font-envy-code-r-nerd-font font-martian-nerd-font font-terminess-ttf-nerd-font font-jetbrains-mono-nerd-font font-fantasque-sans-mono-nerd-font
    # masSafari[1569813296]="1Password for Safari"
    # masSafari[1459809092]="Accelerate for Safari"
    # masSafari[1160374471]="PiPifier"
    # masSafari[1365531024]="1Blocker - Ad Blocker"
    # masSafari[1568262835]="Super Agent for Safari"
    set -g masSafari 1569813296 1459809092 1160374471 1365531024 1568262835
    # masDocs[409183694]="Keynote"
    # masDocs[409203825]="Numbers"
    # masDocs[409201541]="Pages"
    set -g masDocs 409183694 409203825 409201541
    # masUtilities[441258766]="Magnet"
    # masUtilities[937984704]="Amphetamine"
    set -g masUtilities 441258766 937984704
    # masEmail[1176895641]="Spark Classic – Email App"
    # masEmail[1615488683]="Skiff Desktop - Work Privately"
    set -g masEmail 1176895641 1615488683
    # masDesign[1616822987]="Affinity Photo 2"
    # masDesign[1616831348]="Affinity Designer 2"
    # masDesign[1606941598]="Affinity Publisher 2"
    set -g masDesign 1606941598 1616831348 1616822987
    # masApplePro[434290957]="Motion"
    # masApplePro[634148309]="Logic Pro"
    # masApplePro[424389933]="Final Cut Pro"
    # masApplePro[634159523]="MainStage"
    # masApplePro[424390742]="Compressor"
    set -g masApplePro 434290957 634148309 424389933 634159523 424390742
    # masMessenger[1480068668]="Messenger"
    set -g masMessenger 1480068668
    brew tap browsh-org/homebrew-browsh
    brew tap homebrew/cask-fonts
    darwinmenu
  case Linux
    set -g fonts "Meslo" "Mononoki" "FiraCode" "FiraMono" "Iosevka" "Ubuntu" "Hack" "UbuntuMono" "Inconsolata" "EnvyCodeR" "MartianMono" "Terminus" "JetBrainsMono" "FantasqueSansMono" 
    set -g flatpaks com.google.Chrome org.kde.okteta org.inkscape.Inkscape org.fontforge.FontForge arduino-ide-bin anki com.nextcloud.desktopclient.nextcloud tech.feliciano.pocket-casts com.getpostman.Postman org.qbittorrent.qBittorrent com.spotify.Client org.videolan.VLC us.zoom.Zoom org.libreoffice.LibreOffice com.slack.Slack com.fyralabs.SkiffDesktop
    switch $PACKAGE_MANAGER
      case apt
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
        echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
        sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
        sudo apt update
        set -g packages 1password 1password-cli balena-etcher breaktimer-bin discord firefox insync gnupg kitty podman glibc pam lxc libcap apparmor libselinux libseccomp gnutls lua python310 docker-desktop julia cmake nodejs bat htop bandwhich bfs browsh-bin browsh bottom btop cheat-bin curl dooit eza fzf gawk github-cli git hyperfine iftop openssh mosh most neofetch nmap libwebp notcurses parallel ripgrep rsync tealdeer thefuck tmux tree unrar vivid wget xz boost-libs openblas hdf5 imagemagick gnuplot graphviz vtk spotify-tui armadillo libdlibxx gsl pango ncurses opencv thrift lazydocker dive cloc ruby cargo-udeps ghostscript jq dejagnu flex mpfr autogen libisl libffi zlib libxcrypt texinfo bison prettierd pkgconf lua-language-server marksman perl coursier scala php texlive-latex terraform typescript certbot git-extras grpcurl helm kubectx kubectl kustomize lazygit mkcert sampler subversion upx wireguard-tools chromedriver powershell ninja sqlite python-poetry ruff mercurial tree-sitter gzip gofumpt go neovim starship zoxide make pinentry obsidian
      case apk
        apk update 
      case yum
        sudo yum update
      case dnf
        sudo dnf update
      case pacman
        if not command -q paru
          git clone https://aur.archlinux.org/paru.git
          cd paru
          makepkg -si
          paru --gendb 
          paru -Sua
        end
        set -Ux INSTALL_COMMAND "paru -Sy"
        modprobe kvm_amd
        ls -al /dev/kvm
        sudo usermod -aG kvm $USER
        set -g packages 1password 1password-cli balena-etcher breaktimer-bin discord firefox insync gnupg kitty podman glibc pam lxc libcap apparmor libselinux libseccomp gnutls lua python310 docker-desktop julia cmake nodejs bat htop bandwhich bfs browsh-bin browsh bottom btop cheat-bin curl dooit eza fzf gawk github-cli git hyperfine iftop openssh mosh most neofetch nmap libwebp notcurses parallel ripgrep rsync tealdeer thefuck tmux tree unrar vivid wget xz boost-libs openblas hdf5 imagemagick gnuplot graphviz vtk spotify-tui armadillo libdlibxx gsl pango ncurses opencv thrift lazydocker dive cloc ruby cargo-udeps ghostscript jq dejagnu flex mpfr autogen libisl libffi zlib libxcrypt texinfo bison prettierd pkgconf lua-language-server marksman perl coursier scala php texlive-latex terraform typescript certbot git-extras grpcurl helm kubectx kubectl kustomize lazygit mkcert sampler subversion upx wireguard-tools chromedriver powershell ninja sqlite python-poetry ruff mercurial tree-sitter gzip gofumpt go neovim starship zoxide make pinentry obsidian
        linuxmenu
      case emerge
        sudo emerge app-crypt/age
      case zypper
        sudo zypper refresh
        sudo zypper update
      case '*'
        echo "Unsupported OS"
        exit 0
    end

    linuxmenu
  case '*'
    echo "Unsupported OS"
    exit 0
end
