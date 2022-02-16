#!/bin/bash

pidof -q spotifyd && kill $(pidof spotifyd)
spotifyd &
exec footclient --app-id="music" --title="Spotify TUI" spt
