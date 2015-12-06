#! /bin/bash

dotfiles="$HOME/.dotfiles"
git clone git://github.com/andreamichi/dotfiles.git $dotfiles

echo "Installing dotfiles from $dotfiles"

for filepath in $(find ${dotfiles} -name '.*' -type f -mindepth 1); do
  filename="${filepath##*/}"
  echo "Linking $filename"
  rm -rf "$HOME/$filename"
  ln -s "$dotfiles/$filename" "$HOME/$filename"
done

echo "Downloading vim-plug and installing plugins"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
