FROM multiarch/debian-debootstrap:armhf-buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y -q --no-install-recommends install \
      ca-certificates \
      curl \
      apt-transport-https \
      gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -k -sSL https://dtcooper.github.io/raspotify/key.asc | apt-key add -v - && \
    echo "deb https://dtcooper.github.io/raspotify raspotify main" > /etc/apt/sources.list.d/raspotify.list

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
      raspotify \
    && rm -rf /var/lib/apt/lists/*

ENV DEVICE_NAME "raspotify (Docker)"
ENV BITRATE 160
ENV CACHE_ARGS "--disable-audio-cache"
ENV VOLUME_ARGS "--enable-volume-normalisation --linear-volume --initial-volume=100"
ENV BACKEND_ARGS "--backend alsa"

CMD /usr/bin/librespot --name ${DEVICE_NAME} $BACKEND_ARGS --bitrate ${BITRATE} $CACHE_ARGS $VOLUME_ARGS $OPTIONS
