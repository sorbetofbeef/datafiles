#!/bin/bash

class=$1
cmd=$2
dir=$3
file=$4
sudo=$5

if [[ "${sudo}" = y ]]; then
  exec /usr/bin/kitty -1 --app-id "${class}" --title "${class}" --working-directory "${dir}" sudo "${cmd}" "${file}"
else
  exec /usr/bin/kitty -1 --app-id "${class}" --title "${class}" --working-directory "${dir}" "${cmd}" "${file}"
fi

