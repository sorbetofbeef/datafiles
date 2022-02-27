#!/usr/bin/env bash

killall wofi || wofi --show run "$@"
