"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum
import re


class CPHearts(FunkLoadTestCase):
    """This test uses a configuration file CPHearts.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def setAuthToken(self):
        regex = re.compile('content="([^"]+)"\s+name="csrf-token"')
        auth_token = regex.search(self.getBody()).group(1)
        self.addMetadata(**{'auth_token': auth_token})
        return auth_token

    def test_heart_projects(self):
        server_url = self.server_url
        # Get homepage
        self.get(server_url, description="View the home page")

        # Fill out manual signup form
        auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')
        email = Lipsum().getUniqWord() + "@" + Lipsum().getWord() + ".com"
        username = Lipsum().getUniqWord()

        self.addMetadata(**{'auth_token': auth_token})

        for x in range(0, 3):
            self.get(self.server_url + '/users/check_username.json',
                     params=[['username', Lipsum().getWord()]],
                     description='Check username availability')
            self.get(self.server_url + '/users/check_email.json',
                     params=[['username', Lipsum().getWord() + "@" + Lipsum().getWord()]],
                     description='Check email availability')
            self.get(self.server_url + '/users/check_password.json',
                     params=[['username', Lipsum().getWord()]],
                     description='Check password availability')

        self.post(self.server_url + "/users",
                  params=[['user[email]', email],
                          ['user[password]', 'alphabet'],
                          ['user[password_confirmation]', 'alphabet'],
                          ['user[username]', username],
                          ['authenticity_token', auth_token],
                          ['commit', 'Sign up']],
                  description="Create New User")
        self.get(self.server_url, description="View the homepage after signup")
        self.get(self.server_url + "/projects", description='View the projects index')
        project_url = random.choice(self.listHref(url_pattern='/projects/\d*', content_pattern='Show.*'))
        self.get(self.server_url + project_url, description='View a project')

        heart_url = self.listHref(url_pattern='/projects/\d*/(un)?like')[0]

        self.post(self.server_url + heart_url, params=[['authenticity_token', self.setAuthToken()]], description='Heart this project')


if __name__ in ('main', '__main__'):
    unittest.main()
