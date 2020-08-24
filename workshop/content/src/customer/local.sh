#!/bin/bash

export JAVA_TOOL_OPTIONS='-Djava.net.preferIPv4Stack=true'
set -x
ike develop -d customer-v1 -p 8081:8080 -n workspace-demo --route header:ike-session-id=feature-y -r "mvn compile quarkus:dev -Ddebug=5001 -Dsuspend=n -Dquarkus.http.port=8081"
