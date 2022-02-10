#!/bin/bash

pidof -q spotifyd && kill $(pidof spotifyd)
spotifyd &
exec kitty -1 --app-id="music" --title="Spotify TUI" spt
