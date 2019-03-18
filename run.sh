#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

PASSWORD=${PASSWORD:-}
DATADIR=${DATADIR:-/root/.ethereum}

if [ "$PASSWORD" == "" ]; then echo "Password must be set, in order to use swarm non-interactively." && exit 1; fi

echo $PASSWORD > /password

KEYFILE=`find $DATADIR | grep UTC | grep -v tmp | head -n 1` || true
if [ ! -f "$KEYFILE" ]; then echo "No keyfile found. Generating..." && /geth --datadir $DATADIR --password /password account new; fi
KEYFILE=`find $DATADIR | grep UTC | grep -v tmp | head -n 1` || true
if [ ! -f "$KEYFILE" ]; then echo "Could not find nor generate a BZZ keyfile." && exit 1; else echo "Found keyfile $KEYFILE"; fi

# if this file exists, we remove datadir on startup, only keeping the node key
DELETE_DATADIR_HOOK="$DATADIR/delete_datadir"
if [ -f "$DELETE_DATADIR_HOOK" ]; then
  mv $DATADIR/swarm/nodekey /nodekey
  rm -rf $DATADIR/swarm/*
  mv /nodekey $DATADIR/swarm/
  rm $DELETE_DATADIR_HOOK
fi

VERSION=`/swarm version`
echo "Running Swarm:"
echo $VERSION

export BZZACCOUNT="`echo -n $KEYFILE | tail -c 40`" || true
if [ "$BZZACCOUNT" == "" ]; then echo "Could not parse BZZACCOUNT from keyfile." && exit 1; fi

exec /swarm --bzzaccount=$BZZACCOUNT --password /password --datadir $DATADIR $@ 2>&1
