#!/bin/bash

TPM_PATH="$HOME/.config/tmux/plugins/tpm"

if [ ! -d "$TPM_PATH" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
fi

