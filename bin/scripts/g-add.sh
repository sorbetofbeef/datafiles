#!/bin/bash

ENTRY=$1

new_entry () {
  local file=$1
  printf '%s\n' $file
  unset input file
}

common () {
  
}

config () {

}

share () {

}

docs () {

}

filename="${ENTRY##$HOME/*/}"
parent_dir=$(dirname $filename)

echo $filename
echo $parent_dir

# if ! rg -q -i "$ENTRY" "$HOME/$this_dir/.git-add" ; then
#   new_entry "$filename" >> "$HOME/$this_dir/.git-add" ;
# fi
# git add $(cat $PWD/.git-add)

echo $ENTRIES
