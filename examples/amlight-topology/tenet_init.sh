#!/bin/bash

SDX_API="http://127.0.0.1:8183/api/amlight/sdx/v1"
TOPOLOGY_API="http://127.0.0.1:8183/api/kytos/topology/v3"

# SDX-related variables
curl -H 'Content-Type: application/json' -X POST -d'"TENET"' $SDX_API/oxp_name
curl -H 'Content-Type: application/json' -X POST -d'"tenet.net.ac"' $SDX_API/oxp_url

# Per-switch variables

# TENET_SW1
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:11/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "tenet_sw1"}' $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:11/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Cape Town, South Africa"}' $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:11/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:20/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:61/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:99/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:20/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:61/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:99/metadata

# TENET_SW2
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:22/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "tenet_sw2"}' $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:22/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Cape Town, South Africa"}' $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:22/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:22:20/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:22:62/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:22:20/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:22:62/metadata

# TENET_SW3
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:33/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "tenet_sw3"}' $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:33/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Cape Town, South Africa"}' $TOPOLOGY_API/switches/cc:00:00:00:00:00:00:33/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:33:63/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:33:99/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:33:63/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:33:99/metadata

# TENET inter-domain port
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:sax.rnp.br:sax_sw1:42"}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:11:42/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:sax.rnp.br:sax_sw2:43"}' $TOPOLOGY_API/interfaces/cc:00:00:00:00:00:00:22:43/metadata

# Enable links
sleep 3

for LINK in $(curl -sH 'Content-Type: application/json'  $TOPOLOGY_API/links | python -m json.tool | fgrep "\"link\":" | sed 's/[ |,|"]//g'|cut -d":" -f2 | uniq);
  do
    curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/links/$LINK/enable;

    echo '{"packet_loss": 0.00random}' |  sed "s/random/${RANDOM:0:10}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;

    curl -H 'Content-Type: application/json' -X POST -d'{"availability": 99.5}' $TOPOLOGY_API/links/$LINK/metadata;

    echo '{"residual_bandwidth": random}' |  sed "s/random/${RANDOM:0:2}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;

    echo '{"latency": random}' |  sed "s/random/${RANDOM:0:2}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;
  done