#!/bin/bash

# Script to stow bat config

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/stow.sh"

stow_package bat

# Rebuild bat's theme cache so custom themes are picked up
if command -v bat >/dev/null; then
  bat cache --build
fi
