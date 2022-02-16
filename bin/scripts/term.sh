#!/bin/bash

app-id=$1
cmd=$2
dir=$3
file=$4
sudo=$5

if [[ "${sudo}" = y ]]; then
  exec /usr/bin/footclient --app-id "${app-id}" --title "${app-id}" --working-directory "${dir}" sudo "${cmd}" "${file}"
else
  exec /usr/bin/footclient --app-id "${app-id}" --title "${app-id}" --working-directory "${dir}" "${cmd}" "${file}"
fi

