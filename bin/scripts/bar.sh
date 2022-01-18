#!/bin/bash

pidof -q waybar && kill "$(pidof -q waybar)"
exec waybar

