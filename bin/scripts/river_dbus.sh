#!/bin/bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river ;
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
