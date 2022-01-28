#!/bin/bash

# killall -q spotifyd 

[ "$(pgrep -c spotifyd)" -gt 0 ] && systemctl --user stop spotifyd.service
systemctl --user start spotifyd.service
spotify-qt && systemctl --user stop spotifyd.service
