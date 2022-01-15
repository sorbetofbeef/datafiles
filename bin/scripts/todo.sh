#!/bin/sh

todo_file='/home/me/docs/pubs/todo.md'

no_exist() {
    echo "Create new todo file? (Y/n)"
    read -r -n1 create
    if [ "$create" == "n" ]; then
        echo "Bye"
        sleep 2
        exit 0
    else
        touch "$todo_file" &&
        nvim "$todo_file"
    fi
    return
}

if [ -f "$todo_file" ]; then
  nvim "$todo_file"
else
    no_exist
fi

