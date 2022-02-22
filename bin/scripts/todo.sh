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

  cat > "$workspace/${f_title}_$(date '+%m.%d').todo" << EOF
Entry: $title
Due: $due_date
Notes: $notes
EOF

  unset title due_date notes
}

new () {
    echo "Create new todo file? (Y/n)"
    read -r -n1 create
    echo ""
    if [ "$create" = "n" ]; then
        echo "Okay..."
        sleep 1
    else
      create
    fi
    unset create
    return 0
}

show () {
  echo "TODO LIST"

  for todo in "$workspace"/*.todo; do
    bat -f --theme="TwoDark" "$todo"
  done
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

destroy () {
  i=0
  pushd /home/me/workspace/ || return 1
  printf "Remove entry: " ; read choice
  for f in /home/me/workspace/*.todo; do
    i=$((i + 1))
    [[ ! $choice = $i ]] && continue 
    [[ $choice = $i ]] && rm -iv "$f"
  done
  popd || return 1
  unset choice i
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
  
  printf '┏━━━━━━━━━━━━━━━━┓ \n┃   Main Menu    ┃ \n┗━━━┳━━━━━━━━━━┳━┛\n    ┃  (s)how  ┃  \n    ┣━━━━━━━━━━┫  \n    ┃ (c)reate ┃  \n    ┣━━━━━━━━━━┫  \n    ┃  (e)dit  ┃  \n    ┣━━━━━━━━━━┫  \n    ┃ (d)elete ┃  \n    ┣━━━━━━━━━━┫  \n    ┃  (q)uit  ┃  \n    ┗━━━━━━━━━━┛ \n'

  read -r -n1 select
  echo ""

  case $select in 
    c ) 
      echo "Creating new todo item... " 
      clear
      new
      ;;
    s ) 
      echo "Displaying todo items... " 
      clear
      show 
      ;;
    e ) 
      echo "Editing todo item... " 
      clear
      show
      edit 
      ;;
    d ) 
      echo "Destroying todo item... " 
      clear
      show
      destroy 
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
