#!/bin/bash

[[ ! -S $XDG_CACHE_HOME/foot-server.sock ]] &&  foot --server=$XDG_CACHE_HOME/foot-server.sock &
[[ ! -d /run/postgresql ]] && foot sudo systemctl start postgresql.service 

if [[ -S $XDG_CACHE_HOME/foot-server.sock && -d /run/postgresql ]]; then 
	footclient --server=$XDG_CACHE_HOME/foot-server.sock -N -H -a Server --working-directory=$HOME/github.com/SorbetofBeef/go-movies yarn start &
	footclient --server=$XDG_CACHE_HOME/foot-server.sock -N -H -a Server --working-directory=$HOME/github.com/SorbetofBeef/go-movies-backend go run ./cmd/api &
else
	echo ""
fi

if [ $('pgrep' -c --full 'nvim -u /home/me/.local/share/lunarvim/lvim/init.lua src/App.jsx') -eq 0 ]; then
	footclient --app-id ReactCode --working-directory /home/me/github.com/SorbetofBeef/go-movies 'lvim' src/App.jsx &
else 
  echo 'React IDE is running'
fi

if [ $('pgrep' -c --full 'nvim -u /home/me/.local/share/lunarvim/lvim/init.lua cmd/api/main.go') -eq 0 ]; then
	footclient --app-id GoCode --working-directory /home/me/github.com/SorbetofBeef/go-movies-backend 'lvim' cmd/api/main.go &
else
  echo 'Go IDE is running'
fi

