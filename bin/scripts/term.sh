#!/bin/bash

class=$1
cmd=$2
dir=$3
file=$4
doas=$5

if [[ "${doas}" = y ]]; then
  exec /usr/bin/kitty -1 --class "${class}" --title "${class}" --working-directory "${dir}" doas "${cmd}" "${file}"
else
  exec /usr/bin/kitty -1 --class "${class}" --title "${class}" --working-directory "${dir}" "${cmd}" "${file}"
fi

