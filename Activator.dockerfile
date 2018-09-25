FROM alpine:3.8

MAINTAINER KGrid Team "kgrid-developers@umich.edu"

RUN apk update && apk upgrade && \
    apk add openjdk8 && \
    apk add zip && \
    apk add --no-cache curl

RUN addgroup -S kgrid && adduser -S kgrid -G kgrid
USER kgrid
WORKDIR /home/kgrid

RUN mkdir shelf \
 && curl -L -O "https://github.com/kgrid/kgrid-activator/releases/download/kgrid-activator-1.0.1/kgrid-activator-1.0.1.jar" \
 && curl -L -O "https://github.com/kgrid-objects/example-kos/releases/download/1.0.0/hello-world.zip" \
 && unzip *.zip -d shelf

EXPOSE 8080
CMD  java -jar kgrid-activator*.jar --server.port=8080
