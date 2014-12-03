"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class LaPlayaFunkloadHelper(FunkLoadTestCase):
    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')
        print self.test_name
        if self.test_name.find('test_readonly') != 0:
            self.registerAndLogin()

    """This test uses a configuration file CPShowProjects.conf."""
    def registerAndLogin(self):
        self.get(self.server_url, description="View the home page")  # Fill out manual signup form
        auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')
        email = Lipsum().getUniqWord() + "@" + Lipsum().getWord() + ".com"
        username = Lipsum().getUniqWord()

        self.addMetadata(**{'auth_token': auth_token})

        self.post(self.server_url + "/users",
                  params=[['user[email]', email],
                          ['user[password]', 'alphabet'],
                          ['user[password_confirmation]', 'alphabet'],
                          ['user[username]', username],
                          ['authenticity_token', auth_token],
                          ['commit', 'Sign up']],
                  description="Create New User")
