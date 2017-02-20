#!/bin/sh

THRESHOLD_WARN=${WERCKER_GOLINT_THRESHOLD_WARN-5}
THRESHOLD_FAIL=${WERCKER_GOLINT_THRESHOLD_FAIL-10}
GOMETALINTER=`which gometalinter`


LINTLINES=$(${GOMETALINTER} ./... | tee gometalinter_results.txt | wc -l | tr -d " ")

if [ -n "$WERCKER_GOMETALINTER_EXCLUDE" ]; then
  LINTLINES=$(${GOMETALINTER} ./... | grep -vE "$WERCKER_GOMETALINTER_EXCLUDE" | tee gometalinter_results.txt | wc -l | tr -d " ")
else
  LINTLINES=$(${GOMETALINTER} ./... | tee gometalinter_results.txt | wc -l | tr -d " ")
fi

cat gometalinter_results.txt
