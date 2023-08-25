#!/bin/bash

echo "Started proxy server" >&2

java -XX:InitialRAMPercentage=50.0 -XX:+UseContainerSupport -XX:MinRAMPercentage=75.0 -XX:MaxRAMPercentage=75.0 -jar ballerina_proxy_grpc.jar