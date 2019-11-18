    FROM koji/registry.access.redhat.com/ubi7/ubi
    MAINTAINER Red Hat, Inc.
    LABEL com.redhat.component="ubi7-container"
    LABEL name="ubi7"
    LABEL version="7.6"
    LABEL com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI"
    #labels for container catalog
    LABEL summary="Provides the latest release of the Red Hat Universal Base Image 7."
    LABEL description="The Universal Base Image is designed and engineered to be the base layer for all of your containerized applications, middleware and utilities. This base image is freely redistributable, but Red Hat only supports Red Hat technologies through subscriptions for Red Hat products. This image is maintained by Red Hat and updated regularly."
    LABEL io.k8s.display-name="Red Hat Universal Base Image 7"
    LABEL io.openshift.tags="base rhel7"
    ENV container oci
    ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    CMD ["/bin/bash"]
