FROM ubuntu:xenial
MAINTAINER manjebrinkhuis@gmail.com

USER root

# First install some dependencies
RUN apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y \
 	dirmngr \
	gnupg \
	--no-install-recommends \
    wget \
    ca-certificates \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
    locales \
    fonts-liberation
ENV LANG en-US

# Add neurodebian to sources and install fslview
RUN echo "$(wget -O- http://neuro.debian.net/lists/xenial.de-md.full)" >> /etc/apt/sources.list.d/neurodebian.sources.list \ 
  && apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 \
  && apt-get update \
  && apt-get install -y fslview \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd neuro
USER neuro

ENTRYPOINT [ "fslview" ]
