#!/bin/bash
slurp | grim -g - $(xdg-user-dir PICTURES)/screenshots/$(date +'%s.png')
