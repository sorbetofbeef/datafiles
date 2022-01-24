#!/usr/bin/env -s fish

while getopts asd: option; do
  case $ $option in
    a ) lsd --tree $HOME/workspace > ~/workspace/.todo/(date '+%m.%D');;
    s ) bat --theme='TwoDark' -f --style=full $HOME/workspace/.todo/(date '+%m.%D');;
    d );;
done

