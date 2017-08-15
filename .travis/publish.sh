#!/bin/bash

set -x

_results_file="./all.perf"

if [ -n "$TRAVIS_PULL_REQUEST" ] && [ "$TRAVIS_PULL_REQUEST" != "false" ] && [ -f "$_results_file" ]; then
  echo -e "Commenting on PR with the results"

  # send the results to the external server that creates the actual comment (because travis can't use the secrets for PR builds)
  # it uses a simple netcat based server that is listening on 194.213.36.24:2000 and in the message it assumes: token, pr number and the comment itself
  # the token isn't the github oauth token, it's a string that protects from spamming the server by various botnets
  # also we replace all the new lines with '|' because nc isn't good with multiline messages
  echo -e "98cd017b0384164809f95a0c9c71f21b $TRAVIS_PULL_REQUEST `cat $_results_file | tr '\n' '|'`" | nc -4 -w1 194.213.36.24 20000
fi
