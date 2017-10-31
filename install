set -eu

if ! type git > /dev/null; then
  echo 'Error: git not installed.';
  exit 1;
fi

git clone git@github.com:masawada/dotfiles.git $HOME/.dotfiles
exec $HOME/.dotfiles/bin/dotman install
