#!/bin/bash

# SDX-related variables
curl -H 'Content-Type: application/json' -X POST -d'"MyTestingDomain"' http://127.0.0.1:8181/api/amlight/sdx/v1/oxp_name
curl -H 'Content-Type: application/json' -X POST -d'"my_testing_domain.com"' http://127.0.0.1:8181/api/amlight/sdx/v1/oxp_url

# Per-switch variables

# switch1
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "my_switch1"}' http://127.0.0.1:8181/api/kytos/topology/v3/switches/00:00:00:00:00:00:00:01/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' http://127.0.0.1:8181/api/kytos/topology/v3/switches/00:00:00:00:00:00:00:01/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:01:1/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:01:2/metadata

# switch2
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "my_switch2"}' http://127.0.0.1:8181/api/kytos/topology/v3/switches/00:00:00:00:00:00:00:02/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI1, Miami, FL"}' http://127.0.0.1:8181/api/kytos/topology/v3/switches/00:00:00:00:00:00:00:02/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:02:1/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:02:2/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:02:3/metadata

curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:my_other_testing_domain.com:my_router55:eth1/2"}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:02:1/metadata

# switch3
curl -H 'Content-Type: application/json' -X POST -d'{"node_name": "my_switch3"}' http://127.0.0.1:8181/api/kytos/topology/v3/switches/00:00:00:00:00:00:00:03/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"address": "Equinix MI3, Boca Raton, FL"}' http://127.0.0.1:8181/api/kytos/topology/v3/switches/00:00:00:00:00:00:00:03/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:03:1/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:03:2/metadata
curl -H 'Content-Type: application/json' -X POST -d'{"mtu": 9000}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:03:3/metadata

curl -H 'Content-Type: application/json' -X POST -d'{"nni": "urn:sdx:port:my_other_testing_domain.com:my_router24:eth1/4"}' http://127.0.0.1:8181/api/kytos/topology/v3/interfaces/00:00:00:00:00:00:00:03:1/metadata
