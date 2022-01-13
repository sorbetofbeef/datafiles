#!/bin/bash

if [ $(pgrep -c pulsemixer) -gt 0 ]; then
  exec pkill pulsemixer
else
  pulsemixer
fi
