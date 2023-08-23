#!/bin/bash

set -u
set -e
set -o pipefail

export PUBKUBECONFIG=$KUBECONFIG

export PRIVKUBECONFIG=$KUBECONFIG

cd /app

status=0

./run-test.sh || status="$?" || :

mkdir -p $ARTIFACT_DIR/result

# Copy results to ARTIFACT_DIR
cp -r /result/* $ARTIFACT_DIR/result 2>/dev/null || :
cp -r /tmp/test.out $ARTIFACT_DIR/result 2>/dev/null || :

# Prepend junit_ to result xml files
rename '/junit' '/junit_rhsi' ${ARTIFACT_DIR}/result/*.xml 2>/dev/null || :

exit $status

