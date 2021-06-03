import json
import datetime
import pprint
import requests


# This will come from Kytos
nodes_mapping = {"00:00:00:00:00:00:00:01": "Novi01",
                 "00:00:00:00:00:00:00:02": "Novi02",
                 "00:00:00:00:00:00:00:03": "Novi03",
                 "00:00:00:00:00:00:00:04": "Novi04",
                 "00:00:00:00:00:00:00:05": "Novi05",
                 "00:00:00:00:00:00:00:06": "Novi06"}


TOPOLOGY_NAME = "amlight.net"


def get_port_uri(switch, interface):
    try:
        switch_name = nodes_mapping[switch]
    except:
        switch_name = switch
    return f"urn:sdx:port:{TOPOLOGY_NAME}:{switch_name}:{interface}"


def get_port_speed(speed):
    if speed == 100000000:
        return "100GE"
    elif speed == 1250000000:
        return "10GE"
    else:
        return "1GE"


def get_port(node, interface):

    port = dict()
    port["id"] = get_port_uri(node, interface["port_number"])
    port["name"] = interface["name"]
    port["node"] = f"urn:sdx:node:{TOPOLOGY_NAME}:{node}"
    port["inter_domain"] = interface["uni"]
    port["type"] = get_port_speed(interface["speed"])
    port["encapsulation"] = "VLAN"
    port["label"] = "vlan"
    port["swapping_capability"] = "vlan"
    port["label_range"] = ["1", "4000"]
    port["mtu"] = "10000"
    port["status"] = interface["active"]
    port["link_to"] = "TBD"
    return port


def get_ports(node, interfaces):

    ports = list()
    for interface in interfaces.values():
        port_no = interface["port_number"]
        if  port_no != 4294967294:
            ports.append(get_port(node, interface))
    return ports


def get_node(switch):

    node = dict()
    node["name"] = switch["data_path"].split(",")[1].split(": ")[1]
    node["id"] = f"urn:sdx:node:{TOPOLOGY_NAME}t:%s" % node["name"]
    node["location"] = {"address": "Miami,FL",
                        "latitude": switch["metadata"]["lat"],
                        "longitude": switch["metadata"]["lng"]}
    node["ports"] = get_ports(node["name"], switch["interfaces"])
    return node


def get_nodes(switches):

    nodes = list()

    for switch in switches.values():
        node = get_node(switch)
        nodes.append(node)
    return nodes


def get_link(kytos_link):

    link = dict()
    interface_a = int(kytos_link["endpoint_a"]["id"].split(":")[8])
    switch_a = ":".join(kytos_link["endpoint_a"]["id"].split(":")[0:8])
    interface_b = int(kytos_link["endpoint_b"]["id"].split(":")[8])
    switch_b = ":".join(kytos_link["endpoint_b"]["id"].split(":")[0:8])
    if switch_a == switch_b:
        return link

    link["name"] = "%s/%s_%s/%s" % (nodes_mapping[switch_a], interface_a, nodes_mapping[switch_b], interface_b)
    link["id"] = f"urn:sdx:link:{TOPOLOGY_NAME}:%s" % link["name"]
    link["ports"] = [get_port_uri(switch_a, interface_a), get_port_uri(switch_b, interface_b)]
    link["total_bandwidth"] = 1000000
    link["available_bandwidth"] = 1000000
    link["latency"] = 1
    link["packet_loss"] = 0
    link["availability"] = 100

    return link


def get_links(kytos_links):
    links = list()

    for kytos_link in kytos_links.values():
        link = get_link(kytos_link)
        if link:
            links.append(link)
    return links


def get_time_stamp():
    return datetime.datetime.now().strftime("%m%d%y-%H%M%S")


def get_topology(kytos_topology):
    topology = dict()
    topology["name"] = "AmLight-OXP"
    topology["id"] = f"urn:sdx:topology:{TOPOLOGY_NAME}"
    topology["nodes"] = get_nodes(kytos_topology["switches"])
    topology["time_stamp"] = get_time_stamp()
    topology["version"] = 1
    topology["domain_service"] = {}
    topology["links"] = get_links(kytos_topology["links"])

    return topology
