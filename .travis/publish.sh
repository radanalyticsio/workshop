#!/bin/bash

set -x

_results_file="./all.perf"

if [ -n "$TRAVIS_PULL_REQUEST" ] && [ "$TRAVIS_PULL_REQUEST" != "false" ] && [ -f "$_results_file" ]; then
  echo -e "Commenting on PR with the results"
  echo -e "98cd017b0384164809f95a0c9c71f21b $TRAVIS_PULL_REQUEST `cat $_results_file | tr '\n' '|'`" | nc -4 -w1 194.213.36.24 20000
fi
