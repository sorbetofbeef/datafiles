#!/bin/bash

class=$1
cmd=$2
dir=$3
file=$4
doas=$5

if [[ "${doas}" = y ]]; then
  exec /home/me/.local/bin/alacritty --class "${class}" --title "${class}" --working-directory "${dir}" -e doas "${cmd}" "${file}"
else
  exec /home/me/.local/bin/alacritty -1 --class "${class}" --title "${class}" --working-directory "${dir}" -e "${cmd}" "${file}"
fi

