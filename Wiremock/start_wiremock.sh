#!/bin/sh
curl -X POST --data '' "http://localhost:8080/__admin/shutdown" || true
SCRIPT_PATH=${0%/*}
if [ "$0" != "$SCRIPT_PATH" ] && [ "$SCRIPT_PATH" != "" ]; then
    cd $SCRIPT_PATH
fi
java -jar "wiremock-standalone-2.20.0.jar" --verbose > "wiremock-output.txt" 2>&1 &
