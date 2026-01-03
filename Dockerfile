FROM debian:13-slim
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=en_US.UTF-8

RUN apt update && \
    apt install -y --no-install-recommends \
        bash-completion \
        curl \
        dnsutils \
        file \
        gpg \
        inetutils-ftp \
        iproute2 \
        iputils-ping \
        iputils-tracepath \
        jq \
        less \
        locales \
        mtr \
        nano \
        netcat-openbsd \
        net-tools \
        nmap \
        openssh-client \
        openssl \
        p7zip-full \
        rsync \
        tcpdump \
        traceroute \
        unzip \
        wget \
        whois \
        zip && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./templates/.bash_aliases ./templates/.bashrc /root/

RUN ln -s `which python3` /usr/bin/python && \
    cat /etc/profile.d/bash_completion.sh >> ~/.bashrc && \
    sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen en_US.UTF-8
