FROM --rm -ti -u root registry.access.redhat.com/ubi7/ubi

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

USER root

LABEL maintainer="Kostaq Cipo <kostaq.cipo@lhind.dlh.de>"
