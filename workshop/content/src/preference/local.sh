#!/bin/bash

export JAVA_TOOL_OPTIONS='-Djava.net.preferIPv4Stack=true'
set -x
ike develop -d preference-v1 -p 8082:8080 -n workspace-demo -m inject-tcp --route header:ike-session-id=feature-y --session feature-y -r "mvn compile quarkus:dev -Ddebug=5002 -Dsuspend=n -Dquarkus.http.port=8082"
