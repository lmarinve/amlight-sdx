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
#from napps.amlight.sdx.parse_topo import get_data_path_from_kytos_topology_api
from kytos.core.helpers import listen_to
import napps.amlight.sdx.storehouse
from swagger_client import TopologyApi, Topology, Configuration, ConnectionApi, ApiClient
from swagger_client.models import topology
from swagger_client.models.connection import Connection
from swagger_client.rest import ApiException, logger
from pprint import pprint


class Main(KytosNApp):
    """Main class of amlight/sdx NApp.

    This class is the entry point for this NApp.
    """

    # @listen_to('kytos/storehouse.loaded')
    def setup(self):
        """Replace the '__init__' method for the KytosNApp subclass.

        The setup method is automatically called by the controller when your
        application is loaded.

        So, if you have any setup routine, insert it here.
        """
        self.topology_loaded  = False
        self.topology = dict()
        # object to save and load storehouse variable

        # TODO: function that reads kytos.json, and validates that the requirements are there and then run the functions ; counter spproach: napp_loaded variable initialize to 0 , wait, increase

    @listen_to('kytos/storehouse.loaded')
    def load_storehouse(self, event=None):
        """Function meant for validation, to make sure that the storehouse napp has been loaded
        before all the other functions that use it begins to call it."""
        self.storehouse = napps.amlight.sdx.storehouse.StoreHouse(self.controller)

    @listen_to('kytos/topology.*')
    def load_topology(self, event=None):
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
    def unload_topology(self, event=None):
        """Function meant for validation, to make sure that the storehouse napp has been loaded
        before all the other functions that use it begins to call it."""
        self.topology_loaded = False
        self.topology = {}

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

    @staticmethod
    def get_kytos_topology():
        """"""
        kytos_topology = requests.get("http://0.0.0.0:8181/api/kytos/topology/v3").json()
        return kytos_topology["topology"]

    @rest('v1/topology')
    def get_topology_version(self):
        """ REST to return the topology following the SDX data model"""
        return jsonify(self.topology), 200

    # @listen_to('kytos/*.*')  # topology.*
    @listen_to('.*.switch.(new|reconnected)')
    @listen_to('.*.connection.lost')
    @listen_to('.*.switch.interface.created')
    def handle_link_up(self, event):
        """"""
        log.debug("SDX: Event detected")
        if self.topology_loaded:
            self.create_update_topology()
        print(event)
        # TODO: PUT swagger client
        # data: what is returned by get_topology

    def create_update_topology(self):
        """ Function that will take care of initializing the namespace kytos.storehouse.version within the storehouse
        and create a box object containing the version data that will be updated every time a change is detected in
        the topology."""
        if self.topology_loaded:
            self.storehouse.update_box()
            version = self.storehouse.get_data()["version"]
            self.topology = get_topology(self.get_kytos_topology(), version)
        else:
            log.info(" Topology NAPP not loaded yet")
            return {}
        return self.topology

    def swagger_client_post(self):
        """"""
        api_instance = TopologyApi()
        topology_body = self.create_update_topology()
        topology.key_inserted = False
        # topology.save() # save function not found in topology class
        try:
            # create a topology
            logger.warning(topology_body)
            api_response = api_instance.add_topology(topology_body)
            logger.warning(api_response)
        except ApiException as e:
            logger.warning("Exception when calling  topologyApi->add_topology: %s\n" % e)
            return False
        # pass

    def swagger_client_put(self):
        """"""
        api_instance = TopologyApi()
        topology_body = self.create_update_topology()
        topology.key_inserted = False
        # topology.save() # save function not found in topology class
        try:
            # create a topology
            logger.warning(topology_body)
            api_response = api_instance.update_topology(topology_body)
            logger.warning(api_response)
        except ApiException as e:
            logger.warning("Exception when calling  topologyApi->add_topology: %s\n" % e)
            return False

        pass

    # @staticmethod
    # def swagger_place_connection():
    #     """"""
    #     # create an instance of the API class
    #     api_instance = ConnectionApi()
    #     body = Connection()  # Connection | order placed for creating a connection
    #
    #     try:
    #         # Place an connection request from the SDX-Controller
    #         api_response = api_instance.place_connection(body)
    #         pprint(api_response)
    #     except ApiException as e:
    #         print("Exception when calling ConnectionApi->place_connection: %s\n" % e)

    # def swagger_setup(self):
    #     """"""
    #     # TODO: set environmental variables (should be part of the configuration)
    #     configuration = Configuration()
    #     configuration.host = 'http://aw-sdx-lc-1.renci.org:8080/SDX-LC/1.0.0'
    #     # create an instance of the API class
    #     api_instance = ConnectionApi(ApiClient(configuration))
    #     connection_id = 789  # int | ID of the connection that needs to be deleted
    #
    #     try:
    #         # Delete connection order by ID
    #         api_instance.delete_connection(connection_id)
    #     except ApiException as e:
    #         print("Exception when calling ConnectionApi->delete_connection: %s\n" % e)
    #
    #     # create an instance of the API class
    #     api_instance = ConnectionApi(ApiClient(configuration))
    #     connection_id = 789  # int | ID of connection that needs to be fetched
    #
    #     try:
    #         # Find connection by ID
    #         api_response = api_instance.getconnection_by_id(connection_id)
    #         pprint(api_response)
    #     except ApiException as e:
    #         print("Exception when calling ConnectionApi-> getconnection_by_id: %s\n" % e)
    #
    #     # create an instance of the API class
    #     api_instance = ConnectionApi(ApiClient(configuration))
    #     # TODO: create id, name, ports form
    #     body = self.topology  # Connection | order placed for creating a connection
    #
    #     try:
    #         # Place an connection request from the SDX-Controller
    #         api_response = api_instance.place_connection(body)
    #         print("here")
    #         pprint(api_response)
    #     except ApiException as e:
    #         print("Exception when calling ConnectionApi->place_connection: %s\n" % e)
