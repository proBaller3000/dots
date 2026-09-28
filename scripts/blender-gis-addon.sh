#!/usr/bin/env bash
set -euo pipefail

ADDON_URL="https://github.com/domlysz/BlenderGIS/archive/refs/tags/2215.zip"
TMP_ZIP="/tmp/blendergis.zip"

cleanup() {
    rm -f "$TMP_ZIP"
}

trap cleanup EXIT

echo "Downloading BlenderGIS..."
curl -L "$ADDON_URL" -o "$TMP_ZIP"

echo "Installing addon..."

blender --background --python-expr "
import bpy
addon_zip = r'$TMP_ZIP'

bpy.ops.preferences.addon_install(filepath=addon_zip)

# addon module name
module = 'BlenderGIS-2215'

try:
    bpy.ops.preferences.addon_enable(module=module)
except Exception as e:
    print(e)

# save user prefs
bpy.ops.wm.save_userpref()
"

echo "Done."
