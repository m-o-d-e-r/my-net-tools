FROM ubuntu:25.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y iputils-ping mtr \
        iproute2 tcpdump dnsutils \
        nano less netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

COPY ./templates/.bash_aliases ./templates/.bashrc /root/
