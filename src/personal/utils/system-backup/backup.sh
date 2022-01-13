#!/bin/bash

LOOP=true
MAIN_LOOP=true
dots=${HOME}/.config/dotfiles
filelist=${HOME}/.local/share/my-arch/filelist
remote_dots="git@github.com:SorbetofBeef/dotfiles.git"

# check returns false if a user inputs anything but "y"
check(){
  read -r confirm
  if [[ ! "$confirm" == y ]]; then
    return 1
  fi
  return
} 

# err_return returns an error that should move the user along in the script
err_return(){
  msg=$1
  [[ -z $msg ]] && msg="Something went wrong."
  printf "\nError Message: %s. Returning to main menu\n" "$msg"
  sleep 2
  MAIN_LOOP=false
  return 1
}


# err_fatal takes prints a message supplied by an argument and exits program
err_fatal(){
  msg=$1
  [[ -z $msg ]] && msg="Errors have occurred."
  printf "\nError Message: %s. Aborting\n" "$msg"
  sleep 2
  MAIN_LOOP=false
  LOOP=false
  exit 1
}

# bgit wrapper arround git command and its needed arguments
bgit() {
  "/usr/bin/git" --git-dir="$dots" --work-tree="$HOME" "$@"
}

git_init_bare(){
  pushd "${HOME}/.config" || err_return "Could not change to ${HOME}. Does ${HOME} exist?"
    if gh repo create --private $remote_dots; then
        git init --bare "$dots"
        bgit config --local status.showUntrackedfiles no
        bgit add "${HOME}/docs/.updated.txt" || err_return "Couldn't stage ~/docs/.updated.txt"
        bgit commit -m "Initial Commit"
        bgit branch -M main
        bgit remote add origin $remote_dots || err_return "Could not add origin to config"
        bgit push -u origin main || err_return "Could not push commits to Github"
    else
      err_return "Error contacting github through github-cli"
      popd || err_return "WTF!"
      return 1
    fi
  popd || err_return "WTF!"
  return
}

create_repo(){
  echo "Creating new bare git repo with your preconfigured remote repo..."
  echo "Would you like to continue? (y/N)"
  if check; then
    echo "Your git directory will be in ~/.config/dotfiles"
    echo "last updated $(date +%m.%d.%YT_%H:%M)" > "${HOME}/docs/.updated.txt"
    if git_init_bare; then
      echo "Succesfully checked out main branch on remote repo SorbetofBeef/dotfiles"
    else 
      err_return "Error creating repo, check logs"
      return 1
    fi
  else
    err_return "Returning to main menu"
    return 1
  fi
  return
}

git_clone(){
  bgit clone --bare $remote_dots "$dots" || err_fatal "could not initialize bare repo"
  bgit config --local status.showUntrackedfiles no
  echo "Cloned remote git repo..."
  return
}

# Creates or checksout given branch
check_for_branch(){
  echo "*------------------------*"
  echo "       Git Checkout"
  echo ""
  echo "  Branch Status: "
  echo ""
  echo "$(bgit status)"
  echo ""
  echo "  Available branches: "
  echo ""
  for f in "$(bgit branch --list)"; do
    echo "  ${f}"
  done
  echo "*------------------------*"
  echo "  n) Create New Branch.."
  echo "  s) Switch to Branch..."
  echo "  e) Existing Branch...."
  read -r branch_choice
  while [ -z "$BRANCH" ]; do
    case $branch_choice in
      n ) 
        echo "Name your new branch: "
        unset BRANCH
        read -r BRANCH
        echo "Creating branch ${BRANCH}..."
        sleep 1
        bgit checkout -b "$BRANCH"
        ;;
     s )
        echo "Okay which branch do you want to checkout?"
        echo "Branch name?"
        unset BRANCH
        read -r BRANCH
        echo "Switching to your existing branch..."
        sleep 1
        bgit checkout "$BRANCH"
        ;;
      e )
        BRANCH="$(bgit branch --show-current)"
        echo "Existing branch $BRANCH will be used"
        ;;
      * ) 
        echo "That option is unfamiliar"
        unset BRANCH
        err_return
        ;;
    esac
  done

  return
}

edit_filelist(){
  echo "You need to update your filelist."
  echo "Would you like to do so now? (y/N)"
  if check; then
    echo "Opening Neovim..."
    nvim "${filelist}"
  fi
  return
}

# Stages files on the given branch
stage_files(){
  echo "Checking if were using a bare repo and then staging files..."
  if rg -qi "bare" "${dots}/config"; then
    repeat=true
    while [ $repeat = true ]; do 
     if bgit add $(cat ${filelist}); then
       repeat=false
       break
     else
       edit_filelist
       repeat=true
     fi
   done
  else
    err_fatal "not using a git bare directory"
    return 1
  fi
  return
}

# Commits the staged files on the current branch
commit_branch() { 
  echo "Committing staged files from ${BRANCH}..."
  if bgit commit -m "$(date +%m.%d.%Y_%H:%M)"; then
    echo "Successfully committed branch"
  else
    err_fatal "Failed to commit, check logs" 
    return 1
  fi
  return
}

# Pushes commits to the remote specified during repo creation phase
push_commits(){
  echo "Pushing ${BRANCH} to github.com..."
  if bgit push origin "$BRANCH"; then
    echo "Succesffully pushed ${BRANCH} to origin"
  else
    err_return "Failed to push to origin/${BRANCH}, check logs"
    return 1
  fi
  return
}

main_menu() {
  echo ""
  echo "#########################################"
  echo "#########################################"
  echo "##         DOTFILE MANAGEMENT          ##"
  echo "##     $(cat "${HOME}"/docs/.updated.txt)     ##"
  echo "#########################################"
  echo "#########################################"
  echo ""
  echo ""
  echo " Main Menu "
  echo "*---------*"
  echo "i) Initialize a new github repo"
  echo "c) Clone an existing github repo"
  echo "b) Back-up current dotfiles to github repo"
  echo "q) quit"
  read -r menu
  echo ""
  case "$menu" in
    i ) 
      create_repo || err_fatal ""
      return
      ;;
    c )
      git_clone || err_return "Failed to clone repo"
      return
      ;;
    b )
      return
      ;;
    q )
      echo "Exitting now.."
      sleep 1
      exit
      ;;
    * )
      err_return "Invalid command"
      return
      ;;
  esac
  return
}

# Main loop
main() {
  if [[ ! -d $dots ]]; then
    mkdir -pv "$dots"
  fi

  while [ $MAIN_LOOP ]; do
    if main_menu; then
      sleep 1
    else
      MAIN_LOOP=false
      break
    fi

    if check_for_branch; then
      sleep 1
    else
      MAIN_LOOP=false
      break
    fi
    
    if stage_files; then
      sleep 1
    else
      MAIN_LOOP=false
      break
    fi
    
    if commit_branch; then
      sleep 1
    else
      MAIN_LOOP=false
      break
    fi
    
    if push_commits; then
      sleep 1
    else
      MAIN_LOOP=false
      break
    fi
    echo "last updated $(date +%m.%d.%yT%H:%M)" > "${HOME}/docs/.updated.txt"
    echo "Successfully backed up files to SorbetofBeef/dotfiles!" 
  done
}

# APP INITIALIZES
pushd "$HOME" || err_fatal "Failed to enter home directory"
while [ $LOOP ]; do
  main
  echo "Would you like to return to the main menu? (y/N)"
  if check; then
    MAIN_LOOP=true
    LOOP=true
  else
    MAIN_LOOP=false
    LOOP=false
    break
  fi
done
popd || err_fatal "Failed to leave home directory"
