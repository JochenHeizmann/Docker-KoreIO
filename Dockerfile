FROM ubuntu:16.04
MAINTAINER info@intermediaware.de

RUN apt-get update \
    && apt-get -y install git \
    && apt-get -y install openssl libssl-dev \
    && apt-get -y install build-essential \
    && apt-get -y install vim \
    && apt-get -y install curl \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/jorisvink/kore.git /kore \
    && cd /kore \
    && make NOTLS=1 DEBUG=1 NOOPT=1 \
    && make install NOTLS=1 DEBUG=1 NOOPT=1 \
    && rm -rf /kore \
    && apt-get -y purge git build-essential

ADD ./my_app /my_app
WORKDIR /my_app

EXPOSE 8888

CMD ["kodev", "run"]
