FROM ubuntu:xenial

MAINTAINER Herman Junge <herman.junge@consensys.net>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 923F6CA9 \
    && echo "deb http://ppa.launchpad.net/ethereum/ethereum/ubuntu xenial main" \
       | tee -a /etc/apt/sources.list.d/ethereum.list

RUN apt-get update -y \
    && apt-get dist-upgrade -y

RUN apt-get install -y python3 python3-pip

RUN pip3 install --upgrade pip

RUN apt-get install -y automake build-essential git-core libffi-dev \
       libgmp-dev libssl-dev libtool pkg-config python-dev python-pip solc \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN git clone -b python3 https://github.com/divyahansg/raiden.git /apps/raiden \
    && cd /apps/raiden \
    && pip3 install --upgrade -r requirements.txt \
    && python3 setup.py develop

WORKDIR /apps/raiden

EXPOSE 40001/udp

ENTRYPOINT ["raiden"]
