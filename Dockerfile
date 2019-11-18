FROM registry.access.redhat.com/ubi7/ubi

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

USER root

LABEL maintainer="Kostaq Cipo <kostaq.cipo@lhind.dlh.de>"

RUN run --user=root yum install unzip -y && rm -rf /var/cache/yum
RUN run --user=root yum install java-11-openjdk-devel -y && rm -rf /var/cache/yum
