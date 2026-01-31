# Use the official SteamCMD image as base
FROM cm2network/steamcmd:root

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends unzip wget file

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

RUN mkdir tacview
RUN wget https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.4/BepInEx_linux_x64_5.4.23.4.zip
RUN unzip BepInEx_linux_x64_5.4.23.4.zip -d $SERVER_DIR && rm BepInEx_linux_x64_5.4.23.4.zip

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

