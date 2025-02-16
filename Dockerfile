FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.authors="tibor309"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Google Chrome"
LABEL org.opencontainers.image.description="Web accessible google chrome browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/chrome
LABEL org.opencontainers.image.url=https://github.com/tibor309/chrome/packages
LABEL org.opencontainers.image.licenses=GPL-3.0
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV TITLE="Google Chrome"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/chrome/chrome_logo_256x256.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/chrome/chrome_icon_32x32.ico && \
  echo "**** install packages ****" && \
  curl -o \
    /tmp/google-chrome-stable_current_amd64.deb \
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    /tmp/google-chrome-stable_current_amd64.deb && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config