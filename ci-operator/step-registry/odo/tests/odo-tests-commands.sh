#!/bin/bash

set -x
set -o nounset

# Run tests
echo "Executing odo tests..."
scripts/openshiftci-presubmit-all-tests.sh

# Get status
status=$?

# Copy Results and artifacts to $ARTIFACT_DIR
mkdir -p ${ARTIFACT_DIR}/results
cp -r test-*.xml ${ARTIFACT_DIR}/results/ 2>/dev/null || :
rename '/test-' '/junit_test-' ${ARTIFACT_DIR}/results/test-*.xml 2>/dev/null || :

[ $status -ne 0 ] && [ $status -ne 255 ] && exit $status
