"""Main module of amlight/sdx Kytos Network Application.

SDX API
"""

import re
import json
import time
import threading
import requests
from flask import jsonify, request
from kytos.core import rest
from kytos.core import KytosNApp, log
#from napps.amlight.sdx import settings
from napps.amlight.sdx.parse_topo import get_topology
from kytos.core.helpers import listen_to
import napps.amlight.sdx.storehouse


class Main(KytosNApp):
    """Main class of amlight/sdx NApp.

    This class is the entry point for this NApp.
    """

    def setup(self):
        """Replace the '__init__' method for the KytosNApp subclass.

        The setup method is automatically called by the controller when your
        application is loaded.

        So, if you have any setup routine, insert it here.
        """
        self.topology = dict()
        # object to save and load storehouse variable
        self.storehouse = napps.amlight.sdx.storehouse.StoreHouse(self.controller)
        self.create_update_topology()

    def execute(self):
        """Run after the setup method execution.

        You can also use this method in loop mode if you add to the above setup
        method a line like the following example:

            self.execute_as_loop(30)  # 30-second interval.
        """
        pass

    def shutdown(self):
        """Run when your NApp is unloaded.

        If you have some cleanup procedure, insert it here.
        """
        pass

    @staticmethod
    def get_kytos_topology():
        kytos_topology = requests.get("http://0.0.0.0:8181/api/kytos/topology/v3").json()
        return kytos_topology["topology"]

    @rest('v1/topology')
    def get_topology_version(self):
        """ REST to return the topology following the SDX data model"""
        return jsonify(self.topology), 200

    @listen_to('kytos/topology.*')
    def handle_link_up(self, event):
        log.debug("SDX: Event detected")
        self.create_update_topology()

    def create_update_topology(self):
        """"""
        self.storehouse.update_box()
        version = self.storehouse.get_data()["version"]
        self.topology = get_topology(self.get_kytos_topology(), version)
