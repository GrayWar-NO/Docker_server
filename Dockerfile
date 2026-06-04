# Use the official SteamCMD image as base
FROM cm2network/steamcmd:root

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends unzip wget file jq

USER steam

WORKDIR /home/steam/steamcmd

ENV SERVER_DIR /home/steam/Steam/steamapps/common/NuclearOptionServer

RUN mkdir -p $SERVER_DIR

RUN ./steamcmd.sh \
    +force_install_dir $SERVER_DIR \
    +login anonymous \
    +app_info_update 1 \
    +app_info_print 3930080 \
    +app_update 3930080 validate \
    +download_depot 3930080 1006\
    +quit && \
    ./steamcmd.sh \
    +force_install_dir $SERVER_DIR \
    +login anonymous \
    +app_update 3930080 validate \
    +quit

WORKDIR /home/steam

RUN set -eux; \
    BEPINEX_URL=$(wget -qO- https://api.github.com/repos/BepInEx/BepInEx/releases/latest \
        | jq -r '.assets[] | select(.name | test("^BepInEx_linux_x64_.*\\.zip$")) | .browser_download_url'); \
    wget -O /tmp/bepinex.zip "$BEPINEX_URL"; \
    unzip /tmp/bepinex.zip -d "$SERVER_DIR"; \
    rm /tmp/bepinex.zip

RUN chmod +x $SERVER_DIR/run_bepinex.sh

# Expose the server port (default is 27015 for Nuclear Option)
EXPOSE 27015/udp
EXPOSE 7777/udp
EXPOSE 7778/udp
USER root
COPY entry.sh /home/steam/entry.sh
RUN chmod +x /home/steam/entry.sh && chown steam:steam /home/steam/entry.sh

USER steam
CMD ["/home/steam/entry.sh"]
