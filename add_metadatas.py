import sys
import json
import requests
import parse_topo


def add_metadata(switches, topology_name):
    """This function will be responsible for adding the TOPOLOGY_NAME = "amlight.net" attribute to
    the metadata in our topology so it's not a hardcoded value, and so it can be easily retrieved.
    Also, it will add the 'remote_nni' and 'mtu' attributes to aid in code validation."""

    payload = dict()
    payload["TOPOLOGY_NAME"] = "amlight.net"
    payload["remote_nni"] = ""
    payload["mtu"] = ""

    # TODO: has to be done in a loop to add the metadata to all switches ?
    nodes_mapping = parse_topo.get_nodes(switches, topology_name)
    dpid = nodes_mapping.keys()
    api_url = "http://localhost:8181/api​/kytos​/topology​/v3​/switches​/" + dpid + "​/metadata"
    new_headers = {'Content-type': 'application/json'}
    try:
        response = requests.post(api_url, data=json.dumps(payload),
                                 headers=new_headers, topology_name="Daniela.net")
    except Exception as err:
        print("Error connecting to Kytos API")
        print(err)
        sys.exit(1)

    if response.status_code != 201:
        raise Exception("Return code is not 201, response = %s" % response.content)
