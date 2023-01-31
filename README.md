# Getting Started

1. Clone the repository with all the submodules
```shell
git clone --recursive https://github.com/annie444/dotfiles.git "${ZDOTDIR:-$HOME}"
```

2. Create symlinks to the main dotfiles 
```shell
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
> make sure to change the shell with `chsh -s /bin/zsh` or `chsh -s /path/to/executable/zsh`

3. Restart the shell
```shell
exec "$SHELL"
```
