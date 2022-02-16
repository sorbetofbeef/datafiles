#!/bin/bash

exec kitty -1 --class "dev" --title "Neovim IDE" --working-directory="/home/me/github" nvim --cmd ":cd /home/me/github"
