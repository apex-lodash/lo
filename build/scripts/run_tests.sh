#!/bin/bash

# If anything fails in the build exit and don't continue on
set -ev

TESTING_ROOT="$TRAVIS_BUILD_DIR/build/scripts/testing"

cd $TESTING_ROOT
npm install
node getTestResults.js