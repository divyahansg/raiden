FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common vim
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update

RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv
RUN apt-get install -y git

# update pip
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel

RUN apt-get update

RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y solc

RUN apt-get install -y automake build-essential git-core libffi-dev \
       libgmp-dev libssl-dev libtool pkg-config  \
    && rm -rf /var/lib/apt/lists/*

RUN git clone -b custom https://github.com/divyahansg/raiden.git
WORKDIR /raiden
RUN pip install --upgrade -r requirements.txt

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN python3.6 setup.py develop

EXPOSE 40001/udp

ENTRYPOINT ["raiden"]
