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

if [[ -d "${BACKUP_NVIM_DIR}" ]]; then
  echo "[INFO] Restoring user configurations from ${BACKUP_NVIM_DIR} ..."
  cp "${BACKUP_NVIM_DIR}/lua/community.lua" "${NVIM_DIR}/lua/community.lua" 2>/dev/null || true
  cp "${BACKUP_NVIM_DIR}/lua/plugins/"*.lua "${NVIM_DIR}/lua/plugins/" 2>/dev/null || true
fi
