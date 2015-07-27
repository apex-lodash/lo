#!/bin/bash

set -ev

SOL_ROOT="$TRAVIS_BUILD_DIR/build/solenopsis/scripts"

cd $SOL_ROOT
./bsolenopsis push
./bsolenopsis -t run-tests