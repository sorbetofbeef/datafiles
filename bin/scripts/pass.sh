#!/usr/bin/env bash

killall wofi || /home/me/.local/bin/scripts/wofi-pass.lua "$@"
