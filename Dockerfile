FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends cloud-init net-tools vim curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN cloud-init init --local
ADD cloud.cfg /etc/cloud/cloud.cfg
RUN rm /etc/cloud/cloud.cfg.d/05_logging.cfg

RUN mkdir -p /var/lib/cloud/seed/nocloud-net
ADD meta-data /var/lib/cloud/seed/nocloud-net/meta-data

ADD docker-entrypoint.sh /usr/local/bin/
VOLUME /docker-entrypoint.d

ENTRYPOINT ["docker-entrypoint.sh"]
