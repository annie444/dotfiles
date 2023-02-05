#!/usr/bin sh
#{{{                    MARK:Header
#**************************************************************
#####   Author: Analetta Rae Marie
#####   Date: Sat Feb 4 17:45 PST 2023
#####   Purpose: bash script for custom terminal setup
#####   Notes: goal - work on mac and linux
#####   Notes: this script should a one liner installer
#}}}***********************************************************
#{{{                    MARK:dotfiles
#**************************************************************

export ZDOTDIR_OLD="${ZDOTDIR}"
export ZDOTDIR="${HOME}/.dotfiles"

# shows count of steps in installer
INSTALL_COUNTER=1

BACKUP_DIR="$ZDOTDIR/$USER.rc.bak"

#}}}***********************************************************

#{{{                    MARK:Stream tee to LOGFILE
#**************************************************************
clear
# replicate stdout and sterr to LOGFILE
exec > >(tee -a "$LOGFILE")
exec 2>&1

#}}}***********************************************************
#{{{                    MARK:Setup deps
#**************************************************************
# Dependencies
# 1) zinit
# 2) powerlevel10k prompt
# 3) zsh
# 4) zpwr
#etc

dependencies_ary=(zinit p10k zsh zpwr)

#}}}***********************************************************

#{{{                    MARK:installer funcs
#**************************************************************

function usage(){

    echo "Usage :  $0 [options] [--]

    Options:
        -a  Install all dependencies
        -c  Copy just configs
        -n  Do not start tmux at end of installer
        -h  Display this message
        -v  Display script version"

}


function showDeps(){

    {
        printf "Installing ${#dependencies_ary[@]} packages on $ZDOTDIR: "
        for dep in "${dependencies_ary[@]}" ; do
            printf "$dep "
        done
    } | echo
    proceed
}

files=(.p10k.zsh .aliases .exports .extra .functions .hatch-complete.zsh .iterm2_shell_integration.zsh .path .tokens-post.zsh .tokens-pre.zsh .zcompdump .zsh_history)

dirs=(.zpwr/local)

function backup(){

    test -d "$BACKUP_DIR" || mkdir -p "$BACKUP_DIR"
    for file in ${files[@]} ; do
      test -f "${ZDOTDIR_OLD:-$HOME}/$file" && cp "${ZDOTDIR_OLD:-$HOME}/$file" "$BACKUP_DIR" && rm -rf "${ZDOTDIR_OLD:-$HOME}/$file"
    done
    for dir in ${dirs[@]} ; do
        test -d "$HOME/$dir" && cp -R "$HOME/$dir" "$BACKUP_DIR" && rm -rf  "$HOME/$dir"
    done
}

function warnOverwrite(){

    echo "The following will be overwritten: .p10k.zsh, .aliases, .exports, .extra, .functions, .hatch-complete.zsh, .iterm2_shell_integration.zsh, .path, .tokens-post.zsh, .tokens-pre.zsh, .zcompdump, .zsh_history in $HOME"
    echo "These files if they exist will be backed to $BACKUP_DIR"
    echo <<EOF
The following directories if they exist will be backed to $BACKUP_DIR: 
$HOME/${dirs[0]},
EOF
    backup

}

function warnSudo(){

    echo "It is highly recommended to run 'sudo visudo' to allow noninteractive install.  This allows running sudo without a password.  The following line would be added to /etc/sudoers: <Your Username> ALL=(ALL) NOPASSWD:ALL"

}

function pluginsInstall(){

    if ! command -v zpwr &> /dev/null; then
      echo "zpwr not installed..."
      echo "Installing zpwr"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/MenkeTechnologies/zpwr/master/install/s)"
    fi
}

#}}}***********************************************************

#{{{                    MARK:Getopts
#**************************************************************
# opt flags
fullInstall=false
while getopts ":hdVa" opt
do
    case $opt in

        h)  usage; exit 0   ;;
          
        d)  showDeps; exit 0    ;;

        V)  echo "$0 -- Version $VERSION"; exit 0   ;;

        a)  fullInstall=true ;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
            usage; exit 1   ;;

        esac    # --- end of case ---
    done
    shift $(($OPTIND-1))

#}}}***********************************************************

#{{{                    MARK:Install
#**************************************************************
warnOverwrite
warnSudo

if [[ $fullInstall == true ]]; then
  pluginsInstall
fi 

ln -s "${ZDOTDIR:-$HOME}/.zpwr_config.d" "$HOME/.zpwr/local"

rm -rf "$HOME/.zpwr/env/.p10k.zsh" "$HOME/.zpwr/env/.p10k.zsh.zwc"

ln -s "${ZDOTDIR:-$HOME}/.p10k.zsh" "$HOME/.zpwr/env/.p10k.zsh"

ln -s "${ZDOTDIR:-$HOME}/.zpwr_config.d/.tokens-pre.zsh" "${ZDOTDIR:-$HOME}/.zpwr_config.d/.tokens.zsh"

ln -s "${ZDOTDIR:-$HOME}/.zpwr_config.d/.tokens.zsh" "${ZDOTDIR:-$HOME}/.tokens.zsh"

ln -s "${ZDOTDIR:-$HOME}/.zpwr_config.d/.tokens-post.zsh" "${ZDOTDIR:-$HOME}/.tokens-post.zsh"

echo "Regenerating zpwr turbo load"

zpwr recompile
zpwr refreshzwc
zpwr regenzsh
zpwr recompile
