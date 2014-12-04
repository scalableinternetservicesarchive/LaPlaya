"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from LaPlayaFunkloadHelper import LaPlayaFunkloadHelper
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class CPShowProjects(LaPlayaFunkloadHelper):
    """This test uses a configuration file CPShowProjects.conf."""
    def setUp(self):
        LaPlayaFunkloadHelper.setUp(self)

    def test_readonly_view_projects(self):
        self.get(self.server_url, description='View the homepage')
        self.get(self.server_url + "/projects", description='View the projects index')
        for x in range(0, 3):
            next_urls = self.listHref(url_pattern="/projects\?page=.*",
                                      content_pattern="Next.*")
            if len(next_urls) > 0:
                next_url = next_urls[0]
                if next_url is None:
                    break
            else:
                break
            self.get(self.server_url + next_url, description='View the next page of projects')
        project_url = random.choice(self.listHref(url_pattern='/projects/.*', content_pattern='Show.*'))
        if project_url:
            self.get(self.server_url + project_url, description='View a project')


if __name__ in ('main', '__main__'):
    unittest.main()