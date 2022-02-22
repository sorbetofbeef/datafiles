#!/bin/sh

workspace=/home/me/workspace
loop=true

create () {
  printf '\nTitle: '; read -r title
  printf '\nDate Due: '; read -r due_date 
  printf '\nNotes: '; read -r notes

  formatting="${title//[\'\[\]\!\?@#\$%\^&\*\(\)\{\}]}"
  formatting="${formatting//[\ \-\.\,]/\_}"
  formatting="${formatting//\_\_\_/\_}"
  formatting="${formatting//\_\_/\_}"
  formatting="${formatting//\_\_/\_}"
  f_title="${formatting,,}"

  cat > "$workspace/${f_title}_$(date '+%m.%d').todo" << EOF
Title: $title
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

destroy () {
  echo "TODO LIST"
  for item in "$workspace"/*.todo; do 
    echo "$item"
  done

  printf "Remove entry: " ; read choice
  if [[ -z /home/me/workspace/$choice ]]; then
    echo "No choice made."
    echo "Returning to menu..."
    return 0
  else
    if [[ -e /home/me/workspace/$choice ]]; then
      rm -iv "/home/me/workspace/${choice}"
    else 
      echo "Entry does not exist."
      echo "Returning to menu..."

    fi
  fi

}

check () {
  while getopts "ns" opt ; do
    case ${opt} in 
      n ) new; exit 1 ;;
      s ) show; exit 0 ;;
      \? ) echo "invalid option" ;;
    esac
  done
}

main() {
  
  printf '┏━━━━━━━━━━━━━━━━┓ \n┃   Main Menu    ┃ \n┗━━━┳━━━━━━━━━━┳━┛\n    ┃  (s)how  ┃  \n    ┣━━━━━━━━━━┫  \n    ┃ (c)reate ┃  \n    ┣━━━━━━━━━━┫  \n    ┃ (d)elete ┃  \n    ┣━━━━━━━━━━┫  \n    ┃  (q)uit  ┃  \n    ┗━━━━━━━━━━┛ \n'

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
    d ) 
      echo "Destroying todo item... " 
      clear
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
