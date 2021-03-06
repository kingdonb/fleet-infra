#!/bin/bash

set -feuxo pipefail

CLUSTER=./clusters/moo-cluster

gpg --import $CLUSTER/.sops.pub.asc
cd $CLUSTER

kubectl create secret generic \
	--namespace devl \
	--from-literal=GITHUB_TOKEN=$PERSONAL_TOKEN \
	--from-literal=GITHUB_USER=kingdonb \
	--dry-run=client -oyaml \
	github-token-auth > github-token-auth.yaml

sops -e --output-type=yaml github-token-auth.yaml > devl/encrypted-github-token-auth.yaml
