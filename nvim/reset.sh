#!/bin/bash

echo "[INFO] Cleaning up nvim data ..."
rm -rf "${HOME}/.local/share/nvim"
rm -rf "${HOME}/.local/state/nvim"
rm -rf "${HOME}/.cache/nvim"