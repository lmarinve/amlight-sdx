#!/bin/bash

SDX_API="http://127.0.0.1:8182/api/amlight/sdx/v1"
TOPOLOGY_API="http://127.0.0.1:8182/api/kytos/topology/v3"

# SDX-related variables
curl -H 'Content-Type: application/json' -X POST -d'"SAX"' $SDX_API/oxp_name
curl -H 'Content-Type: application/json' -X POST -d'"sax.rnp.br"' $SDX_API/oxp_url

# Per-switch variables

# SAX_SW1
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/dd:00:00:00:00:00:00:11/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "SAX_SW1"}' $TOPOLOGY_API/switches/dd:00:00:00:00:00:00:11/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Fortaleza, Brazil"}' $TOPOLOGY_API/switches/dd:00:00:00:00:00:00:11/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:31/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:40/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:42/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:64/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000, "port_name": "eth31"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:31/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000, "port_name": "eth64"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:64/metadata

# SAX_SW2
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/dd:00:00:00:00:00:00:22/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "SAX_SW2"}' $TOPOLOGY_API/switches/dd:00:00:00:00:00:00:22/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Fortaleza, Brazil"}' $TOPOLOGY_API/switches/dd:00:00:00:00:00:00:22/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:31/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:41/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:43/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:65/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000, "port_name": "eth31"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:31/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000, "port_name": "eth65"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:65/metadata

# AmLight inter-domain port
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:amlight.net:Ampath1:40"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:40/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:tenet.net.ac:tenet_sw1:42"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:11:42/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:amlight.net:SoL2:41"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:41/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:tenet.net.ac:tenet_sw2:43"}' $TOPOLOGY_API/interfaces/dd:00:00:00:00:00:00:22:43/metadata

# Enable links
sleep 3

for LINK in $(curl -sH 'Content-Type: application/json'  $TOPOLOGY_API/links | python -m json.tool | fgrep "\"link\":" | sed 's/[ |,|"]//g'|cut -d":" -f2 | uniq);
  do
    curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/links/$LINK/enable;

    echo '{"link_name": "Link_random"}' |  sed "s/random/${LINK:0:18}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;

    echo '{"packet_loss": 0.00random}' |  sed "s/random/${RANDOM:0:10}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;

    curl -H 'Content-Type: application/json' -X POST -d'{"availability": 99.5}' $TOPOLOGY_API/links/$LINK/metadata;

    echo '{"residual_bandwidth": random}' |  sed "s/random/${RANDOM:0:2}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;

    echo '{"latency": random}' |  sed "s/random/${RANDOM:0:2}/" > /tmp/random.json;
    curl -H 'Content-Type: application/json' -X POST -d@/tmp/random.json $TOPOLOGY_API/links/$LINK/metadata;
  done