#!/bin/bash

ENTRIES=$1

new_entry () {
  local input=$1
  local file="${input##*/}"
  printf '%s\n' $file
  unset input file
 }

for file in $ENTRIES ; do
  if ! rg -q -i "${ENTRIES##*/}" "$PWD/.git-add" ; then
    new_entry "$file" >> "$PWD/.git-add" ;
  fi
done 
git add $(cat $PWD/.git-add)

unset file ENTRIES
