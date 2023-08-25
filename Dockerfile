# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

FROM --platform=linux/amd64 ballerina/ballerina:2201.5.0 AS ballerina-builder

# hadolint ignore=DL3002
USER root
COPY . /src
WORKDIR /src

RUN bal build

FROM --platform=linux/amd64 adoptopenjdk/openjdk11:jre-11.0.18_10-alpine

WORKDIR /home/ballerina

LABEL maintainer="choreo.dev"

RUN addgroup troupe --gid 12000 \
      && adduser --system  --disabled-password --shell /bin/bash --gecos 'ballerina' --uid 11000 --ingroup troupe ballerina \
      && apk update \
      && rm -rf /var/cache/apk/*

RUN apk add --no-cache bash=5.1.16-r0

RUN apk add --update libcrypto1.1==1.1.1t-r2 \
    && apk add --update libssl1.1==1.1.1t-r2 \
    && apk add --update zlib==1.2.12-r3

RUN mkdir jars


COPY resources/ /home/ballerina/resources

COPY --from=ballerina-builder /src/target/bin/ballerina_proxy_grpc.jar /home/ballerina/

# COPY --from=ballerina-builder /src/Config.toml /home/ballerina


RUN chown ballerina /home/ballerina/ballerina_proxy_grpc.jar

RUN ["chmod", "+x", "/home/ballerina/resources/docker-entrypoint.sh"]

EXPOSE  9091

USER ballerina

ENTRYPOINT ["/home/ballerina/resources/docker-entrypoint.sh"]