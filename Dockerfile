# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:arch

# set version label
ARG BUILD_DATE
ARG VERSION
ARG WPSOFFICE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=Selkies \
    NO_FULL=true \
    NO_GAMEPAD=true

RUN \  
  echo "**** install packages ****" && \
  pacman -Sy --noconfirm --needed \    
    git \
    qt6-base \
    tint2 \
    thunar && \
  cd / && \
  ln -s \
    /usr/lib/libtiff.so.6 \
    /usr/lib/libtiff.so.5 && \
  echo "**** application tweaks ****" && \
  mv \
    /usr/bin/thunar \
    /usr/bin/thunar-real && \
  echo "**** cleanup ****" && \
  pacman -Rsn --noconfirm \
    git \
    $(pacman -Qdtq) && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3001

VOLUME /config
