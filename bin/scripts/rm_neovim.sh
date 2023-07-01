#!/bin/bash

main ()
{
  printf "\n\e[32mRemoving all NeoVim associated files and directories...\e[0m\n\n"
  sleep 2
  ( (sudo rm -rfv /usr/local/{bin,lib,share}/nvim && sudo rm -rfv /usr/local/share/man/man1/nvim.1 && rm -rfv /home/me/.local/share/nvim/lazy) && 
    printf '\n\e[32mSuccess!!\e[0m\n\n' ) || 
    (printf '\n\e[31mFailed to remove NeoVim and its associated files!\e[0m\n\n' && return 1)
}

main || exit 1
