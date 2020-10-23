#!/bin/bash

echo "run"

network=`docker inspect vault --format='{{ .HostConfig.NetworkMode }}'`
docker run --rm -t --network=${network} kosprov/wait-on vault:8200 