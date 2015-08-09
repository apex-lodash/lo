#!/bin/bash

SOL_PROPFILE="$HOME/solenopsis.properties"
SOL_HOMEDIR="$HOME/.solenopsis"
SOL_CREDDIR="$SOL_HOMEDIR/credentials"
SOL_CREDFILE="$SOL_CREDDIR/lodash.properties"

SRC_DIR="$TRAVIS_BUILD_DIR/src"

cat >$SOL_PROPFILE <<EOF
solenopsis.ENVIRONMENTS=local lodash
solenopsis.env.HOME=$SOL_HOMEDIR
solenopsis.env.MASTER=local
solenopsis.env.DEPENDENT=lodash
solenopsis.env.local.HOME=$SRC_DIR

sf.antFile=$TRAVIS_BUILD_DIR/build/ant/ant-salesforce-34.jar
#sf.ignoreFile=$SRC_DIR/.sfdcignore
EOF

mkdir -p $SOL_CREDDIR

cat >$SOL_CREDFILE <<EOF
username = $SFDC_USERNAME
password = $SFDC_PASSWORD
token = $SFDC_TOKEN
url = $SFDC_URL
sf.version = 34.0
EOF