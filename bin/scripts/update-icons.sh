#!/bin/bash

sys_dirs=/usr/share/icons
user_dirs=$XDG_DATA_HOME/icons

if [ "$1" = "-u" ]; then
  target_dirs=$user_dirs
else
  target_dirs=$sys_dirs
fi

# update icon cache helper function
function update_all_icons {
  for dir in "${target_dirs}"/*; do
    echo "Updating ${dir}..."
    gtk-update-icon-cache -t -f --include-image-data "${dir}" || exit 1
    echo "Finished with ${dir}."
  done
  sleep 1
  return
}

# main function
function main {
  echo "Starting icon cache updates..."
  sleep 1
  if update_all_icons; then
    echo "Updated all icons successfuly."
    sleep 1
  else
    echo "Failed to updat icons."
    sleep 2
    exit 1
  fi
  echo "Finished, good-bye."
  sleep 2
}

main || exit 1
