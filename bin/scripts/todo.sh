#!/bin/sh

workspace=/home/me/workspace
loop=true

create () {
  printf '\nTitle: '; read -r title
  printf '\nDate Due: '; read -r due_date 
  printf '\nNotes: '; read -r notes

formatting="${title//\ /\-}"
f_title="${formatting,,}"

  cat > "$workspace/${f_title}_$(date '+%m.%d').todo" << EOF
Title: $title
Due: $due_date
Notes: $notes
EOF

}

new () {
    echo "Create new todo file? (Y/n)"
    read -r -n1 create
    echo ""
    if [ "$create" = "n" ]; then
        echo "Okay..."
        sleep 1
        return 0
    else
      create
      return 0
    fi
    return 0
}

show () {
  echo "TODO LIST"

  for todo in "$workspace"/*.todo; do
    bat -f --theme="TwoDark" "$todo"
  done
}


main() {

  while getopts n: options; do
    case $options in 
      n ) new ;;
      ? ) echo "invalid option" ;;
    esac
  done
  
  printf '┏━━━━━━━━━━━━━━━━┓ \n┃   Main Menu    ┃ \n┗━━━┳━━━━━━━━━━┳━┛\n    ┃  (s)how  ┃  \n    ┣━━━━━━━━━━┫  \n    ┃ (c)reate ┃  \n    ┣━━━━━━━━━━┫  \n    ┃  (q)uit  ┃  \n    ┗━━━━━━━━━━┛ \n'

  read -r -n1 select
  echo ""

  case $select in 
    n ) 
      echo "Creating new todo item... " 
      clear
      new
      ;;
    s ) 
      echo "Displaying todo items... " 
      clear
      show 
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
  main
done

unset loop
