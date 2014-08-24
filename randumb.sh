#!/usr/bin/env bash

while read cmd; do if [ $(echo "$RANDOM % 6" | bc) -eq 0 ]; then $cmd; fi; done < $HOME/.bash_history
