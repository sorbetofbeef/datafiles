#!/usr/bin/bash

PG_DATA_DIR="${HOME}/.local/var/lib/postgres/data"
PG_RT_DIR="/run/postgresql"
PG_LOG="$HOME/.local/var/logs/postgres.log"
_pg_lc="$(wc -l "$HOME"/.local/var/logs/postgres.log)"
_start=$(( "${_pg_lc%%\ *}" - 20 ))
_stop=$(( "${_pg_lc%%\ *}" - 0 ))

[[ ! -d $PG_RT_DIR ]] && sudo install -Dd -o "$USER" -m 0700 "$PG_RT_DIR"

start_postgres ()
{
  if pidof -q postgres; then
    ([[ -d /run/postgresql ]] && pg_ctl stop -m smart -D "$PG_DATA_DIR" -l "$PG_LOG") ||
      (printf '\e[1,31mFailed to stop postgres server\e[0m\n' && bat --style="full" -r $_start:$_stop "$PG_LOG" && exit 1 )
    ([[ -d /run/postgresql ]] && pg_ctl start -D "$PG_DATA_DIR" -l "$PG_LOG") ||
      (printf '\e[1,31mFailed to start postgres server\e[0m\n' && bat --style="full" -r $_start:$_stop "$PG_LOG" && exit 1 )
  else
    ([[ -d /run/postgresql ]] && pg_ctl start -D "$PG_DATA_DIR" -l "$PG_LOG") ||
      (printf '\e[1,31mFailed to start postgres server\e[0m\n' && bat --style="full" -r $_start:$_stop "$PG_LOG" && exit 1 )
  fi
}


(start_postgres && tail -f "$PG_LOG" | bat --style=full --paging=never -l log) || (printf "PostgreSQL server failed unexpectedly" && exit 1)


