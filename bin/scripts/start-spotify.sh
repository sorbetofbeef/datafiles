#!/bin/bash

pidof -q spotifyd && kill $(pidof spotifyd)
spotifyd &
exec kitty -1 --class="music" --title="Spotify TUI" spt
