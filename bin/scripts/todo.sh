#!/bin/bash

workspace=/home/me/workspace
loop=true

active="$workspace/active/*.todo"
in_active="$workspace/abandoned/*.todo $workspace/completed/*.todo"
completed="$workspace/completed/*.todo"
abandoned="$workspace/abandoned/*.todo"

show_menu () {
  printf '┏━━━━━━━━━━━━━━━━━━━┓ \n┃      SubMenu      ┃ \n┗━━━┳━━━━━━━━━━━━━┳━┻━━━━━━━━━━━┓\n    ┃  (a)ctive   ┃ (i)nactive  ┃   \n    ┣━━━━━━━━━━━━━╋━━━━━━━━━━━━━┫ \n    ┃ (c)ompleted ┃ a(b)andoned ┃  \n    ┣━━━━━━━━━━━━━╋━━━━━━━━━━━━━┫  \n    ┃   (q)uit    ┃  \n    ┗━━━━━━━━━━━━━┛ \n'
  read -r -n1 status
  printf '\n'

  case "$status" in
    a) 
      show "$active"
      next
      ;;
    i) 
      show "$in_active"
      next
      ;;
    c) 
      show "$completed"
      next
      ;;
    b) 
      show "$abandoned"
      next
      ;;
    q)
      clear
      echo "Quiting to menu..."
      show_loop=false
      return 0
      ;;
    *)
      clear
      echo "Invalid input..."
      ;;
  esac
  unset status
}

show () {
  status=$1
  i=0

  if [[ $status = "$in_active" ]] ; then
    f_status='In-Active'
  else
    f_status="${status%/*}"
    f_status="${f_status##*/}"
    f_status="${f_status^}"
  fi

  clear
  printf '\n\e[1;31;3m        TODO LIST\e[0m\n\n'
  printf ' \e[1;36m|>\e[0m \e[31;3m%s Items\e[0m\n\n' "${f_status}"

  for f in $status; do
    i=$((i + 1))
    printf "\e[1;31m  --\e[0m\e[36m[\e[0m \e[1;31;3mEntry %s\e[0m \e[36m]\e[0m\n" $i
    bat --style grid --italic-text always "$f"
  done 
  unset i f status
}

check_digit () {
  input=$1
  if [[ $input = [[:digit:]] ]]; then
    return 0
  else
    echo "Invalid Input"
    return 1
  fi
}

next () {
  printf '\n \e[1;32m*\e[0m \e[32mPress any key to continue..\e[0m \e[1;32m*\e[0m\n'
  read -r -n1 key
  [[ -n "$key" ]] && return 0
  return 0
}


create () {
  show "$active"
  prio=
  ret_val=1

  _priority () {
    prio=
    flags=(' ' ' ' ' ' ' ')
    
    while [ "$ret_val" -eq 1 ]; do
      printf '\nPriority[1-(4)]: ' ; read -r prio
      if [[ -z $prio ]]; then
        prio=3
        ret_val="$?"
        return 0
      else
        if (check_digit "$prio" && [[ $prio -lt 4 ]]) ; then
          ret_val="$?"
          return 0
        else
          return 1
        fi
      fi
    done
  }

  _due_date () {
    cal
    printf '\nDue: ' ; read -r due

    f_due=${due//.,\//}
    due=${f_due}
  }

  printf '\nCategory: '; read -r category
  printf '\nTitle: ' ; read -r title
    _priority
  _due_date
  printf '\nNotes: ' ; read -r notes

  formatting="${title//[\[\]\!:?@#$%^\&\*]}"
  formatting="${formatting//[\ \-\.\,]/_}"
  formatting="${formatting//____/_}"
  formatting="${formatting//___/_}"
  formatting="${formatting//__/_}"
  formatting="${formatting//__/_}"
  f_title="${formatting,,}"

  cat > "${active%/*}/${prio}0-$(date '+%m.%d')-${f_title}.todo" << EOF
> ${flags[${prio}]} ${category^^}: ${title^[[:word:]]}
|    Due: ${due}
|    NOTES
-      $notes
EOF

  show "$active"
  next
  unset title due_date notes
}

edit () {
  i=0

  show "$active"
  printf "Entry: " ; read -r choice
  check_digit "$choice" || return 1
  for f in $active; do
    i=$((i + 1))
    [[ ! $choice = "$i" ]] && continue 
    [[ $choice = "$i" ]] && nvim "$f" 
  done

  show "$active"
  next
  unset choice i
}

remove_to () {
  target_dir=${1%/*}

  show "$active"
  printf "Entry: " ; read -r choice
  clear
  check_digit "$choice" || return 1
  _remove "$choice" "$target_dir"
  unset choice target_dir
}

_remove () {
  choice=$1
  target_dir=$2
  i=0

  for f in active/*.todo; do
    i=$((i + 1))
    [[ ! $choice = "$i" ]] && continue 
    [[ $choice = "$i" ]] && mv "$f" "${target_dir}"
    action=${target_dir#*/}
    name=${f##*/}
    name=${name##*-}
    name=${name//_/\ }
    echo "You ${action}: \"${name}\" on $(date '+%m.%d.%Y') at $(date '+%H:%M')"
    echo "${action}: $(date '+%m.%d.%Y %H:%M')" >> "${target_dir}/${f##*-}"
    echo "${f%.todo}-$(date '+%m%d.%Y_%H:%M')" >> "${target_dir}/summary"
  done

  show "$target_dir/*.todo"
  next
  unset choice target_dir f i name action
}

check () {
  while getopts "ns" opt ; do
    case ${opt} in 
      n ) new; exit 0 ;;
      s ) show ; exit 0 ;;
      \? ) echo "invalid option" ;;
    esac
  done
  unset opt
}

_menu_ui () {
  printf '┏━━━━━━━━━━━━━━━━┓ \n┃   Main Menu    ┃ \n┗━━━┳━━━━━━━━━━┳━┻━━━━━━━━┓\n    ┃  (s)how  ┃ (f)inish ┃   \n    ┣━━━━━━━━━━╋━━━━━━━━━━┫ \n    ┃ (c)reate ┃ (d)elete ┃  \n    ┣━━━━━━━━━━╋━━━━━━━━━━┫  \n    ┃  (e)dit  ┃  (u)ndo  ┃  \n    ┣━━━━━━━━━━┫━━━━━━━━━━┛  \n    ┃  (q)uit  ┃  \n    ┗━━━━━━━━━━┛ \n'
}

main() {
  show "$active"
  _menu_ui
  read -r -n1 select
  printf '\n'
  
  case $select in 
    s ) # Show active todo items
      clear
      show_loop=true
      while $show_loop; do
        show_menu || show_loop=false
      done
      ;;
    c ) # Create a new todo item
      create
      ;;
    e ) # Edit a todo item
      edit 
      ;;
    f ) # Complete a todo item
      remove_to "$completed"
      ;;
    d ) # Abandon a todo item
      remove_to "$abandoned"
      ;;
    u ) # Undo an abandoned or completed todo item
      undo_from "$in_active"
      ;;
    q ) # Exits the program
      printf '\nQuiting... \n' 
      export loop=false
      ;;
    * ) clear ; printf '\nInvalid selection\n';;
  esac

  unset select
}

check "$@"
while $loop; do 
  pushd $workspace > /dev/null || return 1
  main || loop=false
  popd > /dev/null || return 1
done

unset active completed abandoned loop workspace
