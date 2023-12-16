#!/bin/bash

echo $1 >> /var/tmp/w3m.log
tmux split-window -v
tmux send-keys "w3m $1" C-m
