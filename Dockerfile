ARG busybox_builder
FROM ${busybox_builder}
MAINTAINER vamshi@hasura.io

# Necessary shared libs for ghc
RUN apt-get -y update \
 && apt-get -y install netbase \
 && cp -L --parents -t rootfs /lib/x86_64-linux-gnu/libgcc_s.so.1 \
 && cp -L --parents -t rootfs /usr/lib/x86_64-linux-gnu/gconv/UTF-* \
 && cp -L --parents -t rootfs /usr/lib/x86_64-linux-gnu/gconv/gconv-modules* \
 && cp -Lr --parents -t rootfs /usr/lib/locale/C.UTF-8 \
 && cp -L /etc/protocols rootfs/etc/ \
 && apt-get -y purge netbase \
 && apt-get -y auto-remove \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY build.sh /build.sh
CMD ["/build.sh"]
