#!/bin/sh

workspace=/home/me/workspace
loop=true

create () {
  printf '\n - Entry - '; read -r title
  printf '\n  - Due - '; read -r due_date 
  printf '\n - Notes - '; read -r notes

  formatting="${title//[\'\[\]\!\?@#\$%\^&\*\(\)\{\}]}"
  formatting="${formatting//[\ \-\.\,]/\_}"
  formatting="${formatting//\_\_\_/\_}"
  formatting="${formatting//\_\_/\_}"
  formatting="${formatting//\_\_/\_}"
  f_title="${formatting,,}"

  cat > "$workspace/${f_title}-$(date '+%m.%d').todo" << EOF
> Entry: $title
|   Due: $due_date
|   NOTES
-   $notes
EOF

  unset title due_date notes
}

check () {
  msg=$1
  printf '%s \nContinue? (Y/n)\n'
    read -r -n1 choise
    echo ""
    if [ "$choise" = "n" ]; then
      echo "Okay..."
      return 1
    fi
    unset choise
    return 0
}

show () {
  echo "TODO LIST"

  i=0
  for todo in "$workspace"/*.todo; do
    i=$((i + 1))
    echo "$i"
    bat -f --theme="OneHalfDark" "$todo"
  done
  unset i unset todo
}

edit () {
  i=0
  pushd /home/me/workspace/ || return 1
  printf "Edit entry: " ; read choice
  for f in /home/me/workspace/*.todo; do
    i=$((i + 1))
    [[ ! $choice = $i ]] && continue 
    [[ $choice = $i ]] && nvim "$f" 
  done
  popd || return 1
  unset choice i
}

complete () {
  target_dir=$workspace/.completed
  pushd $workspace || return 1
  printf "Complete entry: " ; read choice
  _disable $choice $target_dir
  popd || return 1
}

abandon () {
  target_dir=$workspace/.abandoned
  pushd $workspace || return 1
  printf "Abandon entry: " ; read choice
  _disable $choice $target_dir
  popd || return 1
}

_disable () {
  choice=$1
  target_dri=$2
  i=0

  for f in *.todo; do
    i=$((i + 1))
    [[ ! $choice = $i ]] && continue 
    [[ $choice = $i ]] && mv "$f" "${target_dir}"
    action=${target_dir##*.}
    name=${f##*/}
    name=${name%-*}
    name=${name//\_/\ }
    echo "You ${action}: \"${name}\" on $(date '+%m.%d.%Y') at $(date '+%H:%M')"
    echo "${action}: $(date '+%m.%d.%Y_%H:%M')" >> "${target_dir}/${f}"
    echo "${f%.todo}-$(date '+%m.%d.%Y_%H:%M')" >> "${target_dir}/summary"
  done
  unset choice target_dir i
}

check () {
  while getopts "ns" opt ; do
    case ${opt} in 
      n ) new; exit 0 ;;
      s ) show; exit 0 ;;
      \? ) echo "invalid option" ;;
    esac
  done
}

main() {
  
  printf '┏━━━━━━━━━━━━━━━━┓ \n┃   Main Menu    ┃ \n┗━━━┳━━━━━━━━━━┳━┻━━━━━━━━┓\n    ┃  (s)how  ┃ (f)inish ┃   \n    ┣━━━━━━━━━━╋━━━━━━━━━━┫ \n    ┃ (c)reate ┃ (d)elete ┃  \n    ┣━━━━━━━━━━╋━━━━━━━━━━┫  \n    ┃  (e)dit  ┃  \n    ┣━━━━━━━━━━┫  \n    ┃  (q)uit  ┃  \n    ┗━━━━━━━━━━┛ \n'

  read -r -n1 select
  echo ""

  case $select in 
    s ) 
      clear
      echo "Displaying todo entries... " 
      sleep 1
      clear
      show 
      ;;
    c ) 
      clear
      check 'About to create a new todo entry... ' || break
      sleep 1
      clear
      create
      ;;
    e ) 
      clear
      check '... ' || break
      sleep 1
      clear
      show
      edit 
      ;;
    f ) 
      clear
      check 'Completing todo item... ' || break
      sleep 1
      clear
      show
      complete 
      ;;
    d ) 
      clear
      check 'Destroying todo item... ' || break
      sleep 1
      clear
      show
      abandon 
      ;;
    q ) 
      echo "Quiting... " 
      sleep 1
      export loop=false
      ;;
    * ) echo "Invalid selection" ; clear ;;
  esac

}

while $loop; do 
  check "$@"
  main
done

unset loop select options workspace
