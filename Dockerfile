FROM debian:stretch-slim

ENV TOR_USER debian-tor
ENV TOR_GROUP debian-tor
ENV TOR_BIN /usr/bin/tor
ENV TOR_ORIGIN_CONFIG_PATH /etc/tor/torrc
ENV TOR_CONFIG_DIR /usr/local/etc/tor
ENV TOR_DATA_DIR /var/lib/tor
ENV TOR_CONFIG_FILE torrc

RUN apt-get update                             && \
    apt-get upgrade -y                         && \
    apt-get install --no-install-recommends -y    \
        ca-certificates apt-transport-https       \
        gnupg2 dirmngr

# Update apt sources
RUN echo 'deb https://deb.torproject.org/torproject.org stretch main' >        \
        /etc/apt/sources.list.d/tor.list                                    && \
    echo 'deb-src https://deb.torproject.org/torproject.org stretch main' >>   \
        /etc/apt/sources.list.d/tor.list

RUN mkdir -p /root/.gnupg                            && \
    echo "disable-ipv6" >> /root/.gnupg/dirmngr.conf && \
    chmod 700 /root/.gnupg                           && \
    chmod 600 /root/.gnupg/dirmngr.conf

RUN gpg2 --no-tty --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89          && \
    gpg2 --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

RUN apt-get update                             && \
    apt-get install --no-install-recommends -y    \
        tor tor-geoipdb                        && \
    apt-get clean

RUN mkdir -p $TOR_CONFIG_DIR && \
    mkdir -p $TOR_DATA_DIR

VOLUME $TOR_CONFIG_DIR $TOR_DATA_DIR

COPY start-tor.sh /usr/local/bin

CMD ["/usr/local/bin/start-tor.sh"]
