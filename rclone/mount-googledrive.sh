#!/bin/bash

# Diretório onde o OneDrive será montado
MOUNT_DIR="$HOME/Documentos/google-drive/"

# Nome da configuração do OneDrive no Rclone
REMOTE_NAME="google-drive:"

# Verifica se o diretório de montagem existe
if [ ! -d "$MOUNT_DIR" ]; then
    mkdir -p "$MOUNT_DIR"
fi

# Verifica se já está montado
if mountpoint -q "$MOUNT_DIR"; then
    zenity --info --text "O $REMOTE_NAME já está montado em: $MOUNT_DIR"
    exit 0
fi

# Monta o OneDrive
rclone mount "$REMOTE_NAME" "$MOUNT_DIR" --vfs-cache-mode full &
sleep 2

# Confirmação
if mountpoint -ne "$MOUNT_DIR"; then
    zenity --error --text "Falha ao montar o $REMOTE_NAME. Verifique a configuração do Rclone."
fi

