#!/bin/sh
curl -X POST --data '' "http://localhost:8080/__admin/shutdown" || true
