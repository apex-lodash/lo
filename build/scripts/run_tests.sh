#!/bin/bash

# If anything fails in the build exit and don't continue on
set -e

TESTING_ROOT="$TRAVIS_BUILD_DIR/build/scripts/testing"

cd $TESTING_ROOT
npm cache clean
npm install --save
node getTestResults.js