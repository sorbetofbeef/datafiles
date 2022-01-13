#!/bin/bash

[[ $(xbps-install -Sun | wc -l) -gt 0 ]]
