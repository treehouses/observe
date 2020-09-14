#!/bin/bash

set -e

#https://hub.docker.com/v2/repositories/library/alpine/tags/latest
alpine_last_updated=$(curl -s https://hub.docker.com/v2/repositories/library/alpine/tags/latest | jq -r '.last_updated')
alpine_amd64_info=$(curl -s https://hub.docker.com/v2/repositories/library/alpine/tags/latest | jq -r '.images[] | select(.architecture=="amd64") | .digest')
alpine_arm64_info=$(curl -s https://hub.docker.com/v2/repositories/library/alpine/tags/latest | jq -r '.images[] | select(.architecture=="arm64") | .digest') #} | .[]
alpine_arm_info=$(curl -s https://hub.docker.com/v2/repositories/balenalib/raspberry-pi-alpine/tags/latest | jq -r '{time: .last_updated, sha: .images | .[0].digest} | .[]')

OUTPUT="-----------------------------alpine_source-----------------------------"
OUTPUT="$OUTPUT amd64~last_updated:$alpine_last_updated $alpine_amd64_info"
OUTPUT="$OUTPUT arm64~last_updated:$alpine_last_updated $alpine_arm64_info"
OUTPUT="$OUTPUT arm~last_updated:$alpine_arm_info"

#https://hub.docker.com/v2/repositories/amd64/node/tags/alpine3.12
node_amd64=$(curl -s https://hub.docker.com/v2/repositories/amd64/node/tags/alpine3.12 | jq -r '{time: .last_updated, sha: .images | .[0].digest} | .[]')
node_arm64=$(curl -s https://hub.docker.com/v2/repositories/balenalib/raspberrypi4-64-node/tags/latest | jq -r '{time: .last_updated, sha: .images | .[0].digest} | .[]')
node_arm=$(curl -s https://hub.docker.com/v2/repositories/balenalib/raspberry-pi-alpine-node/tags/latest | jq -r '{time: .last_updated, sha: .images | .[0].digest} | .[]')

OUTPUT="$OUTPUT ------------------------------node_source------------------------------"
OUTPUT="$OUTPUT amd64~last_updated:$node_amd64"
OUTPUT="$OUTPUT arm64~last_updated:$node_arm64"
OUTPUT="$OUTPUT arm~last_updated:$node_arm -----------------------------------------------------------------------"

for i in ${OUTPUT}
do
  echo ${i}
done