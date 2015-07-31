#!/bin/bash

TEST_PREFIX="lo_test_"
ROOT_DIR="$TRAVIS_BUILD_DIR/src/classes"
TARGET_FILE="$ROOT_DIR/lo_test.cls"
TARGET_FILE_META="$ROOT_DIR/lo_test.cls-meta.xml"

echo "@isTest" > $TARGET_FILE
echo "private class lo_test {" >> $TARGET_FILE

for fname in `find $ROOT_DIR -type f -iname "$TEST_PREFIX*.cls"`
do
	# NOTE: Last sed does not have any whitespace in front.  This should only catch the closing brace.
	#       This whole class is hacky and should be replaced with a pull via the tooling / metadata api
	cat $fname | sed '/^.*@isTest.*$/d' | sed "/^.*private class $TEST_PREFIX.*$/d" | sed '/^}.*$/d' >> $TARGET_FILE
done

echo "}" >> $TARGET_FILE

echo '<?xml version="1.0" encoding="UTF-8"?>' > $TARGET_FILE_META
echo '<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">' >> $TARGET_FILE_META
echo '    <apiVersion>34.0</apiVersion>' >> $TARGET_FILE_META
echo '    <status>Active</status>' >> $TARGET_FILE_META
echo '</ApexClass>' >> $TARGET_FILE_META