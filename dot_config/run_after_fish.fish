#!/usr/bin/env fish

function install_plugin
  if test -z (grep -i "$argv[1]" ~/.config/fish/fish_plugins)
    fisher install $argv[1]
  else
    fisher update $argv[1]
  end
end

if ! test -f ~/.config/fish/functions/fisher.fish
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
end
install_plugin jorgebucaran/fisher
install_plugin PatrickF1/fzf.fish
install_plugin franciscolourenco/done
install_plugin jorgebucaran/spark.fish
install_plugin jorgebucaran/autopair.fish
install_plugin jorgebucaran/getopts.fish
install_plugin nickeb96/puffer-fish
install_plugin z11i/github-copilot-cli.fish
install_plugin gazorby/fish-abbreviation-tips
install_plugin jorgebucaran/nvm.fish
install_plugin dracula/fish
