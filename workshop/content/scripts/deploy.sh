#!/usr/bin/env bash
#
# Deploy services to OpenShift/Istio
# Assumes you are oc-login'd and istio is installed and istioctl available at $ISTIO_HOME
#
MYHOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd -P)"
DEPLOYMENT_DIR="${MYHOME}/src/deployments"

# name of project in which we are working
PROJECT=${PROJECT:-workspace-demo}
ISTIO_NS=${ISTIO_NS:-istio-system}

oc new-project ${PROJECT} || true
oc adm policy add-scc-to-user privileged -z default -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z default -n ${PROJECT}
oc get ServiceMeshMemberRoll default -n ${ISTIO_NS} -o json | jq --arg PROJECT "${PROJECT}" '.spec.members[.spec.members | length] |= $PROJECT' | oc apply -f - -n ${ISTIO_NS}

IKE_DOCKER_REGISTRY=docker.io IKE_DOCKER_REPOSITORY=aslakknutsen NAMESPACE=${PROJECT} IKE_IMAGE_TAG=latest ike install-operator -l -n ${PROJECT}

# deploy gateway
oc apply -n ${PROJECT} -f ${DEPLOYMENT_DIR}/gateway.yaml

# deploy customer
oc apply -n ${PROJECT} -f ${DEPLOYMENT_DIR}/customer.yaml

# deploy preferences
oc apply -n ${PROJECT} -f ${DEPLOYMENT_DIR}/preference.yaml

# deploy recommendation
oc apply -n ${PROJECT} -f ${DEPLOYMENT_DIR}/recommendation.yaml

# deploy fake hosts
#oc apply -n ${PROJECT} -f ${DEPLOYMENT_DIR}/fake-vs.yaml
