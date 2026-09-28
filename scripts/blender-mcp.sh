#!/usr/bin/env bash
set -euo pipefail

check() {
    command -v "$1" >/dev/null || { echo "ERROR: $1 not found. Install it first."; exit 1; }
}

check blender
check uvx
check opencode

echo "Installing Blender MCP addon..."
uvx blender-mcp install-addon

echo "Enabling addon in Blender..."
blender --background --python-expr "
import bpy
try:
    bpy.ops.preferences.addon_enable(module='blender_mcp')
    bpy.ops.wm.save_userpref()
    print('Addon enabled.')
except Exception as e:
    print('Enable failed (enable it manually in Edit > Preferences > Add-ons):', e)
"

UVX_PATH="$(command -v uvx)"
cat <<EOF
Append to opencode.json (~/.config/opencode/opencode.json):

"mcp": {
  "blender": {
    "type": "local",
    "command": ["$UVX_PATH", "blender-mcp"],
    "enabled": true
  }
},
EOF