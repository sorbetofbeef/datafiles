#!/bin/bash

systemctl --user restart spotifyd.service
kitty -1 --class="music" --title="Spotify TUI" spt
