FROM alpine:latest

COPY papermc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq \
    && mkdir /papermc

# Start script
CMD ["bash", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc
