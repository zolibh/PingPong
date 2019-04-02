FROM ubuntu
MAINTAINER Zoli Bharmal
COPY ponger/ponger/ponger /app/
COPY ponger/config.yaml /app/
WORKDIR /app
USER root
CMD  ["./ponger","-c", "config.yaml"]
