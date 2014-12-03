"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class CPComments(FunkLoadTestCase):
    """This test uses a configuration file CPComments.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def test_readonly_view_comment(self):
        server_url = self.server_url
        self.get(server_url, description='View the homepage')
        self.get(server_url + "/projects", description='View the projects index')
        project_url = random.choice(self.listHref(url_pattern='/projects/\d*', content_pattern='Show.*'))
        self.get(server_url + project_url, description='View a project')
        comment_url = random.choice(self.listHref(url_pattern='/projects/\d*/comments/\d*', content_pattern='Permalink.*'))
        self.get(server_url + comment_url, description='Show a specific comment')


if __name__ in ('main', '__main__'):
    unittest.main()