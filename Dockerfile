FROM debian:jessie

RUN useradd -ms /bin/bash test
ENV MONO_USER='test'

ADD . /scripts

WORKDIR /scripts

RUN bash check.bash

WORKDIR /scripts/setup

ENV GO_PACKAGES="github.com/codegangsta/gin"
RUN bash golang.bash

ENV NODE_TOOLS="webpack typescript nodemon"
RUN bash nodejs.bash