. "$HOME/.asdf/asdf.sh"

export ZDOTDIR="${HOME}/.dotfiles"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

for FILE in "${ZDOTDIR:-$HOME}/."{path,exports,aliases,functions,extra,zprompt}; do 
  [ -r "$FILE" ] && [ -f "$FILE" ] && source "$FILE"
done

source "${ZINIT_HOME}/zinit.zsh"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: ";
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=0;

export ZPWR_TMUX_PREFIX_MAC='C-a';
export ZPWR_TMUX_PREFIX_LINUX='C-b';

export ZPWR_GITHUB_ACCOUNT="annie444";

export ZPWR_AUTO_COMPLETE=true;
export ZPWR_AUTO_COMPLETE_DELAY=1;

export ZPWR_EXPAND_SECOND_POSITION=false;
export ZPWR_CORRECT=false;

export ZPWR_BANNER_TYPE=ponies;
export ZPWR_COLORS=true;
export ZPWR_COLORS_SECTIONS=true;

export ZPWR_PLUGIN_MANAGER=zinit
export ZPWR_LOCAL="${ZDOTDIR:-$HOME}/.zpwr_config.d"
export ZPWR_PLUGIN_DIR="${ZDOTDIR:-$HOME}/.plugins"
export ZPWR_PROMPT_FILE="${ZDOTDIR:-$HOME}/.p10k.zsh"
export ZPWR_TOKEN_PRE="${ZDOTDIR:-$HOME}/.tokens-pre.sh"
export ZPWR_TOKEN_POST="${ZDOTDIR:-$HOME}/.tokens-post.sh"

