#!/usr/bin/env bash

IMG_REGISTRY=${IMG_REGISTRY:-quay.io}
IMG_REPOSITORY=${IMG_REPOSITORY:-maistra-demo}

function fail() {
	echo $1
	exit 1
}

for project in customer preference recommendation ; do
	docker push ${IMG_REGISTRY}/${IMG_REPOSITORY}/${project}:v1 || \
	fail "build of $project failed"
done

for version in v2 v3 ; do
	docker push ${IMG_REGISTRY}/${IMG_REPOSITORY}/${project}:${version} || \
	fail "build of $project failed"
done
