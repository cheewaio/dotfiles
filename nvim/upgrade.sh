#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_DIR="${SCRIPT_DIR}/.config/nvim"
BACKUP_NVIM_DIR="${NVIM_DIR}.astronvim_v4.$(date +%Y%m%d)"

if [[ -d "${NVIM_DIR}" ]]; then
  echo "[INFO] Backing up ${NVIM_DIR} to ${BACKUP_NVIM_DIR}"
  mv "${NVIM_DIR}" "${BACKUP_NVIM_DIR}"
fi

echo "[INFO] Cleaning up nvim data ..."
rm -rf "${HOME}/.local/share/nvim"
rm -rf "${HOME}/.local/state/nvim"
rm -rf "${HOME}/.cache/nvim"

echo "[INFO] Fetching latest AstroNvim ..."
git clone --depth 1 https://github.com/AstroNvim/template "${NVIM_DIR}"
rm -rf "${NVIM_DIR}/.git"
