"""Main module of amlight/sdx Kytos Network Application.

SDX API
"""

import requests
from flask import jsonify, request
from kytos.core import rest
from kytos.core import KytosNApp, log
from kytos.core.helpers import listen_to
import napps.amlight.sdx.storehouse
from napps.amlight.sdx.parse_topo import get_topology


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
        self.oxp_url = ""
        self.oxp_name = ""
        self.topology_loaded = False
        self.topology = dict()

    def execute(self):
        """Run after the setup method execution.

        You can also use this method in loop mode if you add to the above setup
        method a line like the following example:

            self.execute_as_loop(30)  # 30-second interval.
        """
        self.load_storehouse()

    def shutdown(self):
        """Run when your NApp is unloaded.

        If you have some cleanup procedure, insert it here.
        """
        pass

    @listen_to('kytos/storehouse.loaded')
    def load_storehouse(self, event=None):  # pylint: disable=W0613
        """Function meant for validation, to make sure that the storehouse napp has been loaded
        before all the other functions that use it begins to call it."""
        self.storehouse = napps.amlight.sdx.storehouse.StoreHouse(self.controller)

    @listen_to('kytos/topology.*')
    def load_topology(self, event=None):  # pylint: disable=W0613
        """Function meant for validation, to make sure that the storehouse napp has been loaded
        before all the other functions that use it begins to call it."""
        if not self.topology_loaded:
            if self.storehouse:
                if self.storehouse.box is not None:
                    self.create_update_topology()
                    self.topology_loaded = True
            else:
                self.topology_loaded = True

    @listen_to('kytos/topology.unloaded')
    def unload_topology(self):  # pylint: disable=W0613
        """Function meant for validation, to make sure that the storehouse napp has been loaded
        before all the other functions that use it begins to call it."""
        self.topology_loaded = False
        self.topology = {}

    @staticmethod
    def get_kytos_topology():
        """retrieve topology from API"""
        kytos_topology = requests.get("http://0.0.0.0:8181/api/kytos/"
                                      "topology/v3").json()
        return kytos_topology["topology"]

    @rest('v1/oxp_url', methods=['POST'])
    def set_oxp_url(self):
        """ REST endpoint to provide the SDX napp with the domain_name
        provided by the operator"""
        try:
            # self.oxp_url = request.get_json()
            self.oxp_url = request.__dict__
            log.info(request.__dict__)
            log.info(type(request))
        except:
            return jsonify(self.oxp_url), 401 

        return jsonify(self.oxp_url), 200

    @rest('v1/oxp_name', methods=['POST'])
    def set_oxp_name(self):
        """ REST endpoint to provide the SDX napp with the domain_name
        provided by the operator"""
        
        self.oxp_name = request.get_json()
        
        return jsonify(self.oxp_name), 200
               
    @rest('v1/oxp_name', methods=['GET'])
    def get_oxp_name(self):
        """ REST endpoint to RETRIEVE the SDX napp domain_name"""
        
        return jsonify(self.oxp_name), 200 
               
    @rest('v1/oxp_url', methods=['GET'])
    def get_oxp_url(self):
        """ REST endpoint to RETRIEVE the SDX napp oxp_url"""
        
        return jsonify(self.oxp_url), 200 

    @rest('v1/topology')
    def get_topology_version(self):
        """ REST to return the topology following the SDX data model"""
        if not self.oxp_url:
            return jsonify("Submit oxp_url previous to requesting topology schema"), 401
            
        if not self.oxp_name:
            return jsonify("Submit oxp_name previous to requesting topology schema"), 401

        return jsonify(self.create_update_topology()), 200

    def create_update_topology(self):
        """ Function that will take care of initializing the namespace
         kytos.storehouse.version within the storehouse and create a
         box object containing the version data that will be updated
         every time a change is detected in the topology."""
        if self.topology_loaded:
            self.storehouse.update_box()
            version = self.storehouse.get_data()["version"]
            self.topology = get_topology(self.get_kytos_topology(), version, self.oxp_url)
        else:
            log.info(" Topology NAPP not loaded yet")
            return {}
        return self.topology
