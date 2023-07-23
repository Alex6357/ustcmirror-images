#!/bin/bash

## EXPORTED IN entry.sh
#TO=

## SET IN ENVIRONMENT VARIABLES
#BIND_ADDRESS=
#TSUMUGU_MAXDELETE=
#TSUMUGU_TIMEZONEFILE=
#TSUMUGU_EXCLUDE=
#TSUMUGU_USERAGENT=
#TSUMUGU_PARSER=
#TSUMUGU_THREADS=
#TSUMUGU_EXTRA=

set -eu
[[ $DEBUG = true ]] && set -x


BIND_ADDRESS=${BIND_ADDRESS:-}
TSUMUGU_MAXDELETE=${TSUMUGU_MAXDELETE:-1000}
TSUMUGU_TIMEZONEFILE=${TSUMUGU_TIMEZONEFILE:-}
TSUMUGU_EXCLUDE=${TSUMUGU_EXCLUDE:-}
TSUMUGU_USERAGENT=${TSUMUGU_USERAGENT:-"tsumugu HTTP Syncing Tool/"$(tsumugu --version | cut -d' ' -f2)}
TSUMUGU_PARSER=${TSUMUGU_PARSER:-"nginx"}
TSUMUGU_THREADS=${TSUMUGU_THREADS:-"2"}
TSUMUGU_EXTRA=${TSUMUGU_EXTRA:-}

if [[ -n $TSUMUGU_TIMEZONEFILE ]]; then
    TSUMUGU_TIMEZONEFILE="--timezone-file $TSUMUGU_TIMEZONEFILE"
fi

if [[ $DEBUG = true ]]; then
    export RUST_LOG="tsumugu=debug"
fi

exec tsumugu sync $TSUMUGU_TIMEZONEFILE \
    --user-agent "$TSUMUGU_USERAGENT" \
    --max-delete "$TSUMUGU_MAXDELETE" \
    --parser "$TSUMUGU_PARSER" \
    --threads "$TSUMUGU_THREADS" \
    $TSUMUGU_EXCLUDE $TSUMUGU_EXTRA "$UPSTREAM" "$TO"
