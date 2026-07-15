#!/bin/sh
if [ -d "/home/steam/plugins" ]; then
    chown -R steam:steam "/home/steam/plugins"
fi

if [ -d "$SERVER_DIR/BepInEx/config" ]; then
    chown -R steam:steam "$SERVER_DIR/BepInEx"
fi

if [ -f "$SERVER_DIR/DedicatedServerConfig.json" ]; then
    chown steam:steam "$SERVER_DIR/DedicatedServerConfig.json"
fi

cp -r /home/steam/plugins "$SERVER_DIR/BepInEx/plugins"

cd "$SERVER_DIR" || exit 1

exec ./run_bepinex.sh NuclearOptionServer.x86_64 -limitframerate 120
