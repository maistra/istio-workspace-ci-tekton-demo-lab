#!/bin/bash

export JAVA_TOOL_OPTIONS='-Djava.net.preferIPv4Stack=true'
set -x
ike develop -d recommendation-v1 -p 8083:8080 -n workspace-demo --session feature-x -r "mvn compile quarkus:dev -Ddebug=5003 -Dsuspend=n -Dquarkus.http.port=8083"
