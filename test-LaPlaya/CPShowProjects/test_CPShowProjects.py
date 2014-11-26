"""Simple FunkLoad test
$Id$
"""
import unittest
#from random import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class CPShowProjects(FunkLoadTestCase):
    """This test use a configuration file CPShowProjects.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def test_critical_path(self):
        server_url = self.server_url
        self.get(server_url + "projects", description="View the projects page")
        self.assert_('List of Projects' in self.getBody(), "Not the correct projects page")

    # def test_critical_path_readonly(self):
    #     server_url = self.server_url
    #     self.get(server_url, description='View root URL')


if __name__ in ('main', '__main__'):
    unittest.main()