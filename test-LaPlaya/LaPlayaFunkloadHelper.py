"""Simple FunkLoad test
$Id$
"""
import unittest
import random
import re
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class LaPlayaFunkloadHelper(FunkLoadTestCase):
    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')
        self.logd("Inside setup for " + self.test_name)
        if self.test_name.find('test_readonly') != 0:
            self.logi("Logging in during setup for " + self.test_name)
            self.registerAndLogin()

    def setAuthToken(self):
        regex = re.compile('content="([^"]+)"\s+name="csrf-token"')
        auth_token = regex.search(self.getBody()).group(1)
        self.addMetadata(**{'auth_token': auth_token})
        return auth_token


    """This test uses a configuration file CPShowProjects.conf."""
    def registerAndLogin(self):
        self.get(self.server_url, description="View the home page")  # Fill out manual signup form

        email = Lipsum().getUniqWord() + "@" + Lipsum().getWord() + ".com"
        username = Lipsum().getUniqWord()

        self.setAuthToken()

        self.post(self.server_url + "/users",
                  params=[['user[email]', email],
                          ['user[password]', 'alphabet'],
                          ['user[password_confirmation]', 'alphabet'],
                          ['user[username]', username],
                          ['authenticity_token', auth_token],
                          ['commit', 'Sign up']],
                  description="Create New User")
