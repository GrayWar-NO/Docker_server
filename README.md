# Docker_server

### Configuring
The game server itself can be configured by editing the `DedicatedServerConfig.json` file in the `config` directory.

### Dockerfile
If you want a raw docker image, you can use this dockerfile to build it. 
It comes with BepInEx preinstalled. 
You can change the BepInEx version by editing the Dockerfile directly.

### Docker compose
This is meant to be used with compose, as it makes deployment much easier.
It automatically sets up volumes so you can pop your plugins right into `config/BepInEx/plugins`, with configs in `config/BepInex/config`, maps in `config/missions`, and the banlist in `config`.
It also automatically exports the bepInEx log output to `config/BepInEx/LogOutput.log`

