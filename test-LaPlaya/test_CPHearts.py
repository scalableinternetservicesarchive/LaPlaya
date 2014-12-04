"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from LaPlayaFunkloadHelper import LaPlayaFunkloadHelper
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum
import re


class CPHearts(LaPlayaFunkloadHelper):
    """This test uses a configuration file CPHearts.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def test_heart_projects(self):
        server_url = self.server_url
        self.get(self.server_url + "/projects", description='View the projects index')
        project_url = random.choice(self.listHref(url_pattern='/projects/\d*', content_pattern='Show.*'))
        self.get(self.server_url + project_url, description='View a project')

        heart_url = self.listHref(url_pattern='/projects/\d*/(un)?like')[0]

        self.post(self.server_url + heart_url, params=[['authenticity_token', self.setAuthToken()]], description='Heart this project')


if __name__ in ('main', '__main__'):
    unittest.main()
