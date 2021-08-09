"""Main module of amlight/sdx Kytos Network Application.

SDX API
"""

import sys
import requests
import time
import threading
from flask import jsonify, request
from swagger_client import TopologyApi
from swagger_client.models import topology
from swagger_client.rest import ApiException, logger
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
        self.topology_loaded = False
        self.topology = dict()
        self.oxp_url = ""

    def napp_validation_thread(self):
        """Function that as a thread, validates that all required napp shave been
        loaded before the amlight-sdx napp, so no exceptions are triggered at run time,
        and other errors can be avoided."""
        t = threading.Thread(target=self.napp_validation_thread())
        t.start()
        t.join()

        time_count = 1
        while time_count <= 10:
            try:
                napps_dict = requests.get("http://127.0.0.1:8181/api/kytos/core/napps_installed/")
                if ['kytos', 'storehouse'] and ['kytos', 'topology'] not in napps_dict:
                    raise Exception
            except:  # pylint: disable=W0703
                print("All required Napps are either NOT installed or NOT enabled")
                time.sleep(time_count)
                if time_count > 6:
                    print("   Still trying... (%s)" % time_count)
                time_count += 1

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
            domain_name = request.get_json()
        except Exception as err:  # pylint: disable=W0703
           return jsonify(err), 400  # 405: method not allowed for requested URL

        self.oxp_url = domain_name

        return jsonify("Success"), 200

    @rest('v1/oxp_name', methods=['POST'])
    def set_oxp_name(self):
        """ REST endpoint to provide the SDX napp with the domain_name
        provided by the operator"""

        try:
            domain_name = request.get_json()
        except Exception as err:  # pylint: disable=W0703
            return jsonify(err), 400

        self.oxp_name = domain_name

        return jsonify("Success"), 200

    @rest('v1/topology')
    def get_topology_version(self):
        """ REST to return the topology following the SDX data model"""
        # if not self.oxp_url:
        #     return jsonify("Submit oxp_url previous to requesting topology schema"), 200

        # return jsonify(self.topology), 200
        return jsonify(self.create_update_topology()), 200

    # @listen_to('.*.connection.lost')
    # @listen_to('.*.switch.interface.created')
    # def handle_link_up(self, event):
    #     """Listen to topology events"""
    #     log.debug("SDX: Event detected")
    #     if self.topology_loaded:
    #         self.create_update_topology()
    #     print(event)
    #     # TODO: PUT swagger client

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

    def swagger_client_post(self):
        """POST"""
        api_instance = TopologyApi()
        topology_body = self.create_update_topology()
        topology.key_inserted = False
        # topology.save() # save function not found in topology class
        try:
            logger.warning(topology_body)
            api_response = api_instance.add_topology(topology_body)
            logger.warning(api_response)
        except ApiException as e:
            logger.warning("Exception when calling topologyApi->add_topology: %s", e)
            return False

    def swagger_client_put(self):
        """PUT"""
        api_instance = TopologyApi()
        topology_body = self.create_update_topology()
        topology.key_inserted = False
        try:
            logger.warning(topology_body)
            api_response = api_instance.update_topology(topology_body)
            logger.warning(api_response)
        except ApiException as e:
            logger.warning("Exception when calling topologyApi->add_topology: %s", e)
            return False
