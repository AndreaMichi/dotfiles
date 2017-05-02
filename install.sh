#! /bin/bash

DOTFILES="$HOME/.dotfiles"
git clone git://github.com/andreamichi/dotfiles.git $DOTFILES

echo "Installing dotfiles from $DOTFILES"

for filepath in $(find ${DOTFILES} -name '.*' -type f -mindepth 1); do
  filename="${filepath##*/}"
  echo "Linking $filename"
  ln -s "$DOTFILES/$filename" "$HOME/$filename"
done

echo "Downloading vim-plug and installing plugins"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Set up git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.d1 'diff HEAD~1'
