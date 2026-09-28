#!/usr/bin/env bash
set -euo pipefail

pkg=$(pacman -Sql | fzf --preview 'pacman -Si {} 2>/dev/null | sed -n "1,12p"')
[ -z "$pkg" ] && exit 0

sudo pacman -S "$pkg"