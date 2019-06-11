#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

PASSWORD=${PASSWORD:-}
DATADIR=${DATADIR:-/root/.puffscoin}

if [ "$PASSWORD" == "" ]; then echo "Password must be set, in order to use swarm non-interactively." && exit 1; fi

echo $PASSWORD > /password

KEYFILE=`find $DATADIR | grep UTC | grep -v tmp | head -n 1` || true
if [ ! -f "$KEYFILE" ]; then echo "No keyfile found. Generating..." && /gpuffs --datadir $DATADIR --password /password account new; fi
KEYFILE=`find $DATADIR | grep UTC | grep -v tmp | head -n 1` || true
if [ ! -f "$KEYFILE" ]; then echo "Could not find nor generate a BZZ keyfile." && exit 1; else echo "Found keyfile $KEYFILE"; fi


# if this file exists, we remove datadir on startup, only keeping the node key
DELETE_DATADIR_HOOK="$DATADIR/delete_datadir"
# if this file exists, we keep the nodekey when deleting the datadir
KEEP_NODEKEY_HOOK="$DATADIR/keep_nodekey"

if [ -f "$DELETE_DATADIR_HOOK" ]; then
  if [ -f "$KEEP_NODEKEY_HOOK" ]; then
    # allow failures because bootnode does not have nodekey
    mv $DATADIR/swarm/nodekey /nodekey || true
  fi

  rm -rf $DATADIR/swarm

  if [ -f "$KEEP_NODEKEY_HOOK" ]; then
    # allow failures because bootnode does not have nodekey
    mkdir -p $DATADIR/swarm || true
    mv /nodekey $DATADIR/swarm/ || true

    rm $KEEP_NODEKEY_HOOK
  else
    rm -rf $DATADIR/keystore
  fi

  rm $DELETE_DATADIR_HOOK
fi

VERSION=`/swarm version`
echo "Running Swarm:"
echo $VERSION

export BZZACCOUNT="`echo -n $KEYFILE | tail -c 40`" || true
if [ "$BZZACCOUNT" == "" ]; then echo "Could not parse BZZACCOUNT from keyfile." && exit 1; fi

exec /swarm --bzzaccount=$BZZACCOUNT --password /password --datadir $DATADIR $@ 2>&1
