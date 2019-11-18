FROM registry.access.redhat.com/ubi7/ubi

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

RUN chgrp -R 0
RUN chmod -R g+rw 

USER root

LABEL maintainer="Kostaq Cipo <kostaq.cipo@lhind.dlh.de>"
