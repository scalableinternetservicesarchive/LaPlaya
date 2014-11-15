"""Simple FunkLoad test
$Id$
"""
import unittest
#from random import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class CPCreateUser(FunkLoadTestCase):
    """This test use a configuration file Simple.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def test_critical_path(self):
        server_url = self.server_url
        self.get(server_url, description="View the user signup page")

        auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')
        email = Lipsum().getUniqWord() + "@" + Lipsum().getWord() + ".com"
        username = Lipsum().getUniqWord()

        self.post(self.server_url + "/users",
            params=[['user[email]', email],
              ['user[password]', 'alphabet'],
              ['user[password_confirmation]', 'alphabet'],
              ['authenticity_token', auth_token],
              ['user[username]', username]
              ['commit', 'Sign up']],
            description="Create New User")

    def test_critical_path_readonly(self):
        server_url = self.server_url
        self.get(server_url, description='View root URL')
        #self.get(server_url + "/users/sign_up", description="View the user signup page")


if __name__ in ('main', '__main__'):
    unittest.main()