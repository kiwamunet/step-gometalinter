#!/bin/sh

THRESHOLD_WARN=${WERCKER_GOLINT_THRESHOLD_WARN-5}
THRESHOLD_FAIL=${WERCKER_GOLINT_THRESHOLD_FAIL-10}
GOMETALINTER=`which gometalinter`


LINTLINES=$(${GOMETALINTER} ./... | tee gometalinter_results.txt | wc -l | tr -d " ")

cat gometalinter_results.txt
if [ "$LINTLINES" -ge "${THRESHOLD_FAIL}" ]; then echo "Time to tidy up: $LINTLINES lint warnings." > "$WERCKER_REPORT_MESSAGE_FILE"; fail "Time to tidy up."; fi
if [ "$LINTLINES" -ge "${THRESHOLD_WARN}" ]; then echo "You should be tidying soon: $LINTLINES lint warnings." > "$WERCKER_REPORT_MESSAGE_FILE"; warn "You should be tidying soon."; fi
if [ "$LINTLINES" -gt 0 ]; then echo "You are fairly tidy: $LINTLINES lint warnings." > "$WERCKER_REPORT_MESSAGE_FILE"; fi
