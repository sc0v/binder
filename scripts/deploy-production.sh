#!/bin/bash
set -e

TAG=${1:-master}

podman stop binder
podman rm binder
podman rmi ghcr.io/sc0v/binder-production:$TAG
podman run \
  --name binder \
  --network binder-mysql-network \
  -dt \
  -p 3000:3000/tcp \
  --env-file /home/sc0v/binder-production.env \
  -v binder-private:/build/config/private \
  -v binder-logs:/build/log \
  ghcr.io/sc0v/binder-production:$TAG
