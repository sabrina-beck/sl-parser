#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

buildDir="build/"
testResultDir="${buildDir}tests/"

mkdir -p $testResultDir

for testFile in tests/input/*; do

  testNumber=$(echo $testFile | sed -e 's/[^0-9]//g')
  echo -n "Running test $testNumber"

  testResultPath=$(find tests/output -regextype posix-egrep -regex ".*$testNumber.*")

  ./build/main < $testFile > $testResultPath

  DIFF=$(diff $testResultPath tests/output/${testResultFile})
  if [ "$DIFF" != "" ]
  then
    echo -e " | ${RED}FAILED${NO_COLOR}"
  else
    echo -e " | ${GREEN}SUCCESS${NO_COLOR}"
  fi
done