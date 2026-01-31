#!/bin/sh
# --------------------------------------------------
# 1. If any of the config directories/files were
#    mounted as root, change ownership to steam.
# --------------------------------------------------
if [ -d "$SERVER_DIR/BepInEx/config" ]; then
    chown -R steam:steam "$SERVER_DIR/BepInEx"
fi

if [ -f "$SERVER_DIR/DedicatedServerConfig.json" ]; then
    chown steam:steam "$SERVER_DIR/DedicatedServerConfig.json"
fi

cd "$SERVER_DIR" || exit 1
#rm steam_appid.txt


exec ./run_bepinex.sh NuclearOptionServer.x86_64 -limitframerate 120

#exec sh

