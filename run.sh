#!/bin/sh

THRESHOLD_WARN=${WERCKER_GOLINT_THRESHOLD_WARN-5}
THRESHOLD_FAIL=${WERCKER_GOLINT_THRESHOLD_FAIL-10}

go get -v -u github.com/alecthomas/gometalinter
GOMETALINTER=`which gometalinter`
`which gometalinter` --install --update

LINTLINES=$(${GOMETALINTER} ./... | tee gometalinter_results.txt | wc -l | tr -d " ")

if [ -n "$WERCKER_GOMETALINTER_EXCLUDE" ]; then
  LINTLINES=$(${GOMETALINTER} ./... | grep -vE "$WERCKER_GOMETALINTER_EXCLUDE" | tee gometalinter_results.txt | wc -l | tr -d " ")
else
  LINTLINES=$(${GOMETALINTER} ./... | tee gometalinter_results.txt | wc -l | tr -d " ")
fi

cat gometalinter_results.txt
if [ "$LINTLINES" -ge "${THRESHOLD_FAIL}" ]; then echo "Time to tidy up: $LINTLINES gometalinter warnings." > "$WERCKER_REPORT_MESSAGE_FILE"; fail "Time to tidy up."; fi
if [ "$LINTLINES" -ge "${THRESHOLD_WARN}" ]; then echo "You should be tidying soon: $LINTLINES gometalinter warnings." > "$WERCKER_REPORT_MESSAGE_FILE"; warn "You should be tidying soon."; fi
if [ "$LINTLINES" -gt 0 ]; then echo "You are fairly tidy: $LINTLINES gometalinter warnings." > "$WERCKER_REPORT_MESSAGE_FILE"; fi
