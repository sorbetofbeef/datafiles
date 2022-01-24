#!/bin/bash

PIX_DIR="${HOME}/media/wp"
SYM_LINK="${PIX_DIR}/current-bg"

err(){
  msg="$1"
  code="$?"
  printf '%s. Error Code %d\n' "${msg}" "${code}"
}

change_wallpaper(){
  new_wallpaper="${PIX_DIR}/${FILE}"

  if [[ -e $new_wallpaper ]]; then
    ln -sfv "$new_wallpaper" "$SYM_LINK"
  else
    mv "${SYM_LINK}~" "${SYM_LINK}"
    return 1
  fi
  printf 'Linked %s to %s...\n' "$FILE" "$SYM_LINK"
  rm "${SYM_LINK}~"
}

restart_sway(){
  if [[ -e ${SYM_LINK} ]]; then
    riverctl exit && echo "Restarting river..."
  else
    err "Symbolic link was not created properly"
    return 1
  fi
}

mv "$SYM_LINK" "${SYM_LINK}~"
echo "Wallpaper Listing:"
ls --color=auto "$PIX_DIR"

echo "Enter title of desired wallpaper: "
read -r FILE 
echo "$FILE"
if change_wallpaper; then
  echo "Set wallpaper succesfully!" 
else
  err "Specified image does not exist" 
  exit 1
fi

echo "Restarting Sway..."
[[ -n $new_wallpaper ]] && restart_sway || exit $? 
echo "Bye!"

