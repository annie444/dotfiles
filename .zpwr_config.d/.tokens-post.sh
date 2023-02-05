for FILE in "${ZDOTDIR:-$HOME}/."{extra,zprompt}; do 
  [ -r "$FILE" ] && [ -f "$FILE" ] && source "$FILE"
done
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(pyenv virtualenv-init -)"

zinit ice lucid nocompile wait'0a'
zinit load kiurchv/asdf.plugin.zsh
zinit load djui/alias-tips

zinit unload MenkeTechnologies/zsh-expand &>/dev/null

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

