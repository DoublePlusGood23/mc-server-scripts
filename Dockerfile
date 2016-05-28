FROM java:8
MAINTAINER dpg 
ENV APT_GET_UPDATE 2015-10-03 
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libmozjs-24-bin \
  imagemagick \
  lsof \
  nano \
  sudo \
  vim \
  && apt-get clean
RUN update-alternatives --install /usr/bin/js js /usr/bin/js24 100
RUN wget -O /usr/bin/jsawk https://github.com/micha/jsawk/raw/master/jsawk
RUN chmod +x /usr/bin/jsawk
RUN useradd -M -s /bin/false --uid 1000 mc \
  && mkdir /data \
  && mkdir /config \
  && mkdir /mods \
  && mkdir /plugins \
  && chown mc:mc /data /config /mods /plugins
EXPOSE 25565
COPY start.sh /start
COPY start-minecraft.sh /start-minecraft
VOLUME ["/data"]
VOLUME ["/mods"]
VOLUME ["/config"]
VOLUME ["/plugins"]
COPY server.properties /tmp/server.properties
WORKDIR /data
CMD [ "/start" ]
# Special marker ENV used by MCCY management tool 
ENV MC_IMAGE=YES 
ENV UID=1002 GID=1002 
ENV MOTD Mixacron MC Server 
ENV JVM_OPTS -Xmx4096M -Xms2048M 
ENV TYPE=BUKKIT VERSION=1.9.2 FORGEVERSION=RECOMMENDED LEVEL=world PVP=true DIFFICULTY=normal LEVEL_TYPE=DEFAULT GENERATOR_SETTINGS= WORLD= MODPACK=
