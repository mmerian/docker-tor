FROM debian:buster-slim

ENV TOR_USER debian-tor
ENV TOR_GROUP debian-tor
ENV TOR_BIN /usr/bin/tor
ENV TOR_ORIGIN_CONFIG_PATH /etc/tor/torrc
ENV TOR_CONFIG_DIR /usr/local/etc/tor
ENV TOR_DATA_DIR /var/lib/tor
ENV TOR_CONFIG_FILE torrc

RUN apt-get update                                   && \
    apt-get upgrade -y                               && \
    apt-get install --no-install-recommends -y          \
        ca-certificates apt-transport-https wget gnupg2

RUN echo 'deb https://deb.torproject.org/torproject.org buster main' >        \
        /etc/apt/sources.list.d/tor.list                                    && \
    echo 'deb-src https://deb.torproject.org/torproject.org buster main' >>   \
        /etc/apt/sources.list.d/tor.list

RUN wget -O - https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | apt-key add -

RUN apt-get update                             && \
    apt-get install --no-install-recommends -y    \
        tor tor-geoipdb nyx                    && \
    apt-get clean

RUN mkdir -p $TOR_CONFIG_DIR && \
    mkdir -p $TOR_DATA_DIR

VOLUME $TOR_CONFIG_DIR $TOR_DATA_DIR

COPY start-tor.sh /usr/local/bin

CMD ["/usr/local/bin/start-tor.sh"]
