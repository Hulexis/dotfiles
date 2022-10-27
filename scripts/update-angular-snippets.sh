#!/bin/sh

# Removing stuff
rm -r ~/.config/nvim/lua/custom/snippets/angular

mkdir ~/.config/nvim/lua/custom/snippets/angular
(cd ~/.config/nvim/lua/custom/snippets/angular/ && git init)

pushd ~/.config/nvim/lua/custom/snippets/angular/
git init
git remote add -f origin https://github.com/johnpapa/vscode-angular-snippets.git
git config core.sparseCheckout true

echo "snippets" >>.git/info/sparse-checkout
echo "package.json" >>.git/info/sparse-checkout

git pull origin main

mv snippets/* .
rm -r snippets
rm -r .git

popd
