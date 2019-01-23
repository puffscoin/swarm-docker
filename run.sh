#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

PASSWORD=${PASSWORD:-}
DATADIR=${DATADIR:-/root/.ethereum/}

if [ "$PASSWORD" == "" ]; then echo "Password must be set, in order to use swarm non-interactively." && exit 1; fi

echo $PASSWORD > /password

KEYFILE=`find $DATADIR | grep UTC | head -n 1` || true
if [ ! -f "$KEYFILE" ]; then echo "No keyfile found. Generating..." && /geth --datadir $DATADIR --password /password account new; fi
KEYFILE=`find $DATADIR | grep UTC | head -n 1` || true
if [ ! -f "$KEYFILE" ]; then echo "Could not find nor generate a BZZ keyfile." && exit 1; else echo "Found keyfile $KEYFILE"; fi

VERSION=`/swarm version`

export BZZACCOUNT="`echo -n $KEYFILE | tail -c 40`" || true
if [ "$BZZACCOUNT" == "" ]; then echo "Could not parse BZZACCOUNT from keyfile." && exit 1; fi

BZZKEY=$(/swarm --bzzaccount=$BZZACCOUNT --password /password print-keys | grep bzzkey | cut -c 8-15)
HOSTTAG="$POD_NAME-$BZZKEY"

echo "Running Swarm:"
echo "Hosttag: $HOSTTAG"
echo "BzzAccount: $BZZACCOUNT"
echo "Version: $VERSION"

exec /swarm --bzzaccount=$BZZACCOUNT \
            --metrics.influxdb.host.tag=$HOSTTAG \
            --password=/password \
            --datadir=$DATADIR $@ 2>&1
