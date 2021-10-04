#!/bin/bash

SDX_API="http://127.0.0.1:8181/api/amlight/sdx/v1"
TOPOLOGY_API="http://127.0.0.1:8181/api/kytos/topology/v3"

# SDX-related variables
curl -H 'Content-Type: application/json' -X POST -d'"AmLight"' $SDX_API/oxp_name
curl -H 'Content-Type: application/json' -X POST -d'"amlight.net"' $SDX_API/oxp_url

# Per-switch variables

# Ampath1
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:11/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "Ampath1"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:11/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:11/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:1/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:2/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:3/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:9/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:11/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:40/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:50/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:1/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:2/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:3/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:9/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:11/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:40/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:50/metadata

# Ampath2
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:12/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "Ampath2"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:12/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:12/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:1/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:4/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:8/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:10/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:12/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:51/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:1/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:4/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:8/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:10/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:12/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:12:51/metadata

# SouthernLight2
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:13/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "SoL2"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:13/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix SP4, Sao Paulo, Brazil"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:13/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:2/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:3/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:5/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:17/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:41/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:52/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:2/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:3/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:5/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:17/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:41/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:52/metadata

# SanJuan
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:14/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "SanJuan"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:14/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Hub787, San Juan, Puerto Rico"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:14/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:14:7/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:14:8/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:14:53/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:14:7/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:14:8/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:14:53/metadata

# AndesLight2
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:15/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "AndesLight2"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:15/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "CenturyLink, Santiago, Chile"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:15/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:4/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:6/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:7/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:54/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:4/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:6/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:7/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:15:54/metadata

# AndesLight3
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:16/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "AndesLight3"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:16/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "CenturyLink, Santiago, Chile"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:16/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:16:5/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:16:6/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:16:55/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:16:5/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:16:6/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:16:55/metadata

# Ampath3
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:17/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "Ampath3"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:17/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:17/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:17:9/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:17:10/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:17:56/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:17:9/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:17:10/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:17:56/metadata

# Ampath4
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:18/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "Ampath4"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:18/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI3, Boca Raton, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:18/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:11/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:13/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:14/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:16/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:57/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:11/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:13/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:14/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:16/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:18:57/metadata

# Ampath5
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:19/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "Ampath5"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:19/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:19/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:12/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:13/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:15/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:58/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:12/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:13/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:15/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:19:58/metadata

# Ampath7
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:20/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "Ampath7"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:20/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:20/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:20:16/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:20:17/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:20:59/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:20:16/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:20:17/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:20:59/metadata

# JAX1
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:21/enable
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "JAX1"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:21/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "CenturyLink, Jacksonville, FL"}' $TOPOLOGY_API/switches/aa:00:00:00:00:00:00:21/metadata
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:21:14/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:21:15/enable
curl -H 'Content-Type: application/json' -X POST $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:21:60/enable
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:21:14/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:21:15/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:21:60/metadata

# AmLight inter-domain port
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:sax.net:Sax01:40"}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:11:40/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:sax.net:Sax02:41"}' $TOPOLOGY_API/interfaces/aa:00:00:00:00:00:00:13:41/metadata
