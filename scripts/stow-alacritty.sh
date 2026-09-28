#!/bin/bash

# Script to stow alacritty config

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/stow.sh"

stow_package alacritty
