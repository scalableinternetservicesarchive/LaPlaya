"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class CPCreateUser(FunkLoadTestCase):
    """This test uses a configuration file Simple.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def test_signup_path(self):
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


if __name__ in ('main', '__main__'):
    unittest.main()