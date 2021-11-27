#!/bin/sh

WAL_TEMPLATE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wal/templates"

# Make template dir
mkdir -p "$WAL_TEMPLATE_DIR"

# copy colors.lua to templates dir (Required)
cp ./extra/wal/colors.lua "$WAL_TEMPLATE_DIR"

# Restart wal
command -v wal >/dev/null 2>&1 \
   && wal -R -t -e -n >/dev/null 2>&1 \
   || echo "Please install pywal first! For more info read: https://github.com/dylanaraps/pywal"

