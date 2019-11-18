FROM registry.access.redhat.com/ubi7/ubi

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

USER root

LABEL maintainer="Kostaq Cipo <kostaq.cipo@lhind.dlh.de>"

RUN run -u rootyum update --disablerepo=* --enablerepo=ubi-7-appstream --enablerepo=ubi-7-baseos -y && rm -rf /var/cache/yum
RUN run -u root yum install unzip -y && rm -rf /var/cache/yum
RUN run -u root yum install java-11-openjdk-devel -y && rm -rf /var/cache/yum
