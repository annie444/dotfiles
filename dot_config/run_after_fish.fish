#!/usr/bin/env fish

function install_fish_plugin -a package -a file
    if test -f $file
        fisher install $package
    else
        fisher update $package
    end
end

if ! test -f ~/.config/fish/functions/fisher.fish
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
end

if ! test -f ~/.config/fish/fish_plugins
    set_color red
    echo "fish_plugins file not found! Creating an empty one."
    set_color normal
    touch ~/.config/fish/fish_plugins
end

install_fish_plugin jorgebucaran/fisher ~/.config/fish/functions/fisher.fish

fisher update
