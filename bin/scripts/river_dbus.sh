#!/bin/bash

dbus-update-activation-environment --systemd SEATD_SOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river ;
