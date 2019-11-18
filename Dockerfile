FROM registry.access.redhat.com/ubi7/ubi

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

USER root

LABEL maintainer="Kostaq Cipo <kostaq.cipo@lhind.dlh.de>"

# Update image

RUN yum update --disablerepo=* --enablerepo=ubi-7-appstream --enablerepo=ubi-7-baseos -y && rm -rf /var/cache/yum
RUN yum install unzip -y && rm -rf /var/cache/yum
RUN yum install java-11-openjdk-devel -y && rm -rf /var/cache/yum

ENV ARTIFACTORY_API="AKCp5Zjz35khuBt5ZR9jYQLrFB4TVqiXuoDDzFY5oXNtSoTuaVwraxkXfCQaLQ5JfHMuczR28"
ENV ARTIFACTORY_URL="https://ocrepo.lhind.app.lufthansa.com/artifactory"

ENV SONAR_VERSION=7.8 \
    SONARQUBE_HOME=/opt/sonarqube \
    # Database configuration
    # Defaults to using H2
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL= \
    LANG=en_US.utf8 \
    JAVA_HOME=/usr/lib/jvm/jre

USER root

# Http port
EXPOSE 9000

# ADD root /

LABEL name="sonarqube" \
      vendor="SonarSource" \
      version="${SONAR_VERSION}-rhel7" \
      run='docker run -di \
            --name ${NAME} \
            -p 9000:9000 \
            $IMAGE' \
      io.k8s.description="SonarQube" \
      io.k8s.display-name="SonarQube" \
      io.openshift.build.commit.author="Red Hat Systems Engineering <refarch-feedback@redhat.com>" \
      io.openshift.expose-services="9000:9000" \
      io.openshift.tags="sonarqube,sonar,sonarsource" 

RUN set -x \
    
    cd /opt && \
    curl -o sonarqube.zip -SL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
                --retry 9 --retry-max-time 0 -C - && \
    curl -o sonarqube.zip.asc -SL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONAR_VERSION}.zip.asc \
                --retry 9 --retry-max-time 0 -C - && \
    unzip sonarqube.zip && \
    mv sonarqube-${SONAR_VERSION} sonarqube && \
    rm sonarqube.zip* && \
    rm -rf ${SONARQUBE_HOME}/bin/*

COPY run.sh ${SONARQUBE_HOME}/bin/
ENV PATH=$PATH:${SONARQUBE_HOME}/bin
RUN useradd -l -u sonar -r -g 0 -m -s /sbin/nologin \
        -c "sonarqube application user" sonarqube && \
    chown -R sonar:0 ${SONARQUBE_HOME} && \
    chmod -R g=u ${SONARQUBE_HOME} && \
    chmod ug+x ${SONARQUBE_HOME}/bin/run.sh

VOLUME ["${SONARQUBE_HOME}/data", "${SONARQUBE_HOME}/extensions"]

USER sonar
WORKDIR ${SONARQUBE_HOME}
ENTRYPOINT run.sh
