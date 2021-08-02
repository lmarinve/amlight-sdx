
_node = "s1"

_interface = {
  'active': True,
  'enabled': True,
  'id': '00:00:00:00:00:00:00:01:1',
  'link': '',
  'lldp': True,
  'mac': '9e:8d:61:cd:23:9b',
  'metadata': {},
  'name': 's1-eth1',
  'nni': False,
  'port_number': 1,
  'speed': 1250000000.0,
  'switch': '00:00:00:00:00:00:00:01',
  'type': 'interface',
  'uni': True
}

_switches = {
  '00:00:00:00:00:00:00:01': {
    'active': True,
    'connection': '172.17.0.1:56032',
    'data_path': '',
    'dpid': '00:00:00:00:00:00:00:01',
    'enabled': True,
    'hardware': '',
    'id': '00:00:00:00:00:00:00:01',
    'interfaces': {},
    'manufacturer': '',
    'metadata': {
      'lat': '0.0',
      'lng': '-30.0'
    },
    'name': '00:00:00:00:00:00:00:01',
    'ofp_version': '0x04',
    'serial': '',
    'software': None,
    'type': 'switch'
  },
  '00:00:00:00:00:00:00:03': {
    'active': True,
    'connection': '172.17.0.1:56028',
    'data_path': '',
    'dpid': '00:00:00:00:00:00:00:03',
    'enabled': True,
    'hardware': '',
    'id': '00:00:00:00:00:00:00:03',
    'interfaces': {},
    'manufacturer': '',
    'metadata': {
      'lat': '0.0',
      'lng': '-20.0'
    },
    'name': '00:00:00:00:00:00:00:03',
    'ofp_version': '0x04',
    'serial': '',
    'software': None,
    'type': 'switch'
  }
}

_switch = {
  'active': True,
  'connection': '172.17.0.1:59592',
  'data_path': 's1',
  'dpid': '00:00:00:00:00:00:00:01',
  'enabled': True,
  'hardware': 'Open vSwitch',
  'id': '00:00:00:00:00:00:00:01',
  'interfaces': {
    '00:00:00:00:00:00:00:01:1': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:01:1',
      'link': '',
      'lldp': True,
      'mac': '9e:8d:61:cd:23:9b',
      'metadata': {},
      'name': 's1-eth1',
      'nni': False,
      'port_number': 1,
      'speed': 1250000000.0,
      'switch': '00:00:00:00:00:00:00:01',
      'type': 'interface',
      'uni': True
    },
    '00:00:00:00:00:00:00:01:2': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:01:2',
      'link': 'cf0f4071be426b3f745027f5d22bc61f8312ae86293c9b28e7e66015607a9260',
      'lldp': True,
      'mac': '2a:eb:d4:86:9b:71',
      'metadata': {},
      'name': 's1-eth2',
      'nni': True,
      'port_number': 2,
      'speed': 1250000000.0,
      'switch': '00:00:00:00:00:00:00:01',
      'type': 'interface',
      'uni': False
    },
    '00:00:00:00:00:00:00:01:4294967294': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:01:4294967294',
      'link': '',
      'lldp': True,
      'mac': '32:51:a9:15:d2:43',
      'metadata': {},
      'name': 's1',
      'nni': False,
      'port_number': 4294967294,
      'speed': 0,
      'switch': '00:00:00:00:00:00:00:01',
      'type': 'interface',
      'uni': True
    }
  },
  'manufacturer': 'Nicira, Inc.',
  'metadata': {
    'lat': '0.0',
    'lng': '-20.0'
  },
  'name': '00:00:00:00:00:00:00:01',
  'ofp_version': '0x04',
  'serial': 'None',
  'software': '2.5.9',
  'type': 'switch'
}

_kytos_links = {
  '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30': {
    'active': True,
    'enabled': True,
    'endpoint_a': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:02:3',
      'link': '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30',
      'lldp': True,
      'mac': '5a:37:77:53:a0:cb',
      'metadata': {},
      'name': 's2-eth3',
      'nni': True,
      'port_number': 3,
      'speed': 1250000000.0,
      'switch': '00:00:00:00:00:00:00:02',
      'type': 'interface',
      'uni': False
    },
    'endpoint_b': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:03:2',
      'link': '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30',
      'lldp': True,
      'mac': '82:cf:b2:08:3e:3e',
      'metadata': {},
      'name': 's3-eth2',
      'nni': True,
      'port_number': 2,
      'speed': 1250000000.0,
      'switch': '00:00:00:00:00:00:00:03',
      'type': 'interface',
      'uni': False
    },
    'id': '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30',
    'metadata': {}
  },
  'cf0f4071be426b3f745027f5d22bc61f8312ae86293c9b28e7e66015607a9260': {
    'active': True,
    'enabled': True,
    'endpoint_a': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:02:2',
      'link': 'cf0f4071be426b3f745027f5d22bc61f8312ae86293c9b28e7e66015607a9260',
      'lldp': True,
      'mac': 'e2:21:5d:47:aa:b3',
      'metadata': {},
      'name': 's2-eth2',
      'nni': True,
      'port_number': 2,
      'speed': 1250000000.0,
      'switch': '00:00:00:00:00:00:00:02',
      'type': 'interface',
      'uni': False
    },
    'endpoint_b': {
      'active': True,
      'enabled': True,
      'id': '00:00:00:00:00:00:00:01:2',
      'link': 'cf0f4071be426b3f745027f5d22bc61f8312ae86293c9b28e7e66015607a9260',
      'lldp': True,
      'mac': '2a:eb:d4:86:9b:71',
      'metadata': {},
      'name': 's1-eth2',
      'nni': True,
      'port_number': 2,
      'speed': 1250000000.0,
      'switch': '00:00:00:00:00:00:00:01',
      'type': 'interface',
      'uni': False
    },
    'id': 'cf0f4071be426b3f745027f5d22bc61f8312ae86293c9b28e7e66015607a9260',
    'metadata': {}
  }
}


_kytos_link = {
  'active': True,
  'enabled': True,
  'endpoint_a': {
    'active': True,
    'enabled': True,
    'id': '00:00:00:00:00:00:00:03:2',
    'link': '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30',
    'lldp': True,
    'mac': '82:cf:b2:08:3e:3e',
    'metadata': {},
    'name': 's3-eth2',
    'nni': True,
    'port_number': 2,
    'speed': 1250000000.0,
    'switch': '00:00:00:00:00:00:00:03',
    'type': 'interface',
    'uni': False
  },
  'endpoint_b': {
    'active': True,
    'enabled': True,
    'id': '00:00:00:00:00:00:00:02:3',
    'link': '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30',
    'lldp': True,
    'mac': '5a:37:77:53:a0:cb',
    'metadata': {},
    'name': 's2-eth3',
    'nni': True,
    'port_number': 3,
    'speed': 1250000000.0,
    'switch': '00:00:00:00:00:00:00:02',
    'type': 'interface',
    'uni': False
  },
  'id': '4d42dc0852278accac7d9df15418f6d921db160b13d674029a87cef1b5f67f30',
  'metadata': {}
}

_version = 1

_kytos_topology = {'links': {},
                   'switches': {
                    '00:00:00:00:00:00:00:01': {
                      'active': True,
                      'connection': '172.17.0.1:60886',
                      'data_path': '',
                      'dpid': '00:00:00:00:00:00:00:01',
                      'enabled': True,
                      'hardware': '',
                      'id': '00:00:00:00:00:00:00:01',
                      'interfaces': {},
                      'manufacturer': '',
                      'metadata': {
                        'lat': '0.0',
                        'lng': '-20.0'
                      },
                      'name': '00:00:00:00:00:00:00:01',
                      'ofp_version': '0x04',
                      'serial': '',
                      'software': None,
                      'type': 'switch'
                    },
                    '00:00:00:00:00:00:00:02': {
                      'active': True,
                      'connection': '172.17.0.1:60888',
                      'data_path': '',
                      'dpid': '00:00:00:00:00:00:00:02',
                      'enabled': True,
                      'hardware': '',
                      'id': '00:00:00:00:00:00:00:02',
                      'interfaces': {},
                      'manufacturer': '',
                      'metadata': {
                        'lat': '0.0',
                        'lng': '-30.0'
                      },
                      'name': '00:00:00:00:00:00:00:02',
                      'ofp_version': '0x04',
                      'serial': '',
                      'software': None,
                      'type': 'switch'
                    },
                    '00:00:00:00:00:00:00:03': {
                      'active': True,
                      'connection': '172.17.0.1:60890',
                      'data_path': '',
                      'dpid': '00:00:00:00:00:00:00:03',
                      'enabled': True,
                      'hardware': '',
                      'id': '00:00:00:00:00:00:00:03',
                      'interfaces': {},
                      'manufacturer': '',
                      'metadata': {
                        'lat': '0.0',
                        'lng': '-10.0'
                      },
                      'name': '00:00:00:00:00:00:00:03',
                      'ofp_version': '0x04',
                      'serial': '',
                      'software': None,
                      'type': 'switch'
                    }
                  }
                }