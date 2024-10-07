#!/usr/bin/env bash

bundle install --path vendor/bundle

echo
echo "ATTENTION: Add the command below in your '~/.zshrc' if you use zsh (ex. MacOS)!!!"
echo
echo "alias rake='noglob rake'"
echo
