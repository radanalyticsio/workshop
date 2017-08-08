#!/bin/bash

_results_file="./all-results.perf"

if [ -n "$TRAVIS_PULL_REQUEST" ] && [ "$TRAVIS_PULL_REQUEST" != "false" ] && [ -f "$_results_file" ]; then
  echo -e "Commenting on PR with the results"
  curl -i -XPOST -H "Authorization: token $GITHUB_TOKEN" \
   -d '{"body":"Results:\n'`cat $_results_file`'\n:balloon: :balloon: :balloon:"}' \
   https://api.github.com/repos/radanalyticsio/workshop-notebook/issues/$TRAVIS_PULL_REQUEST/comments 1>&2
fi
