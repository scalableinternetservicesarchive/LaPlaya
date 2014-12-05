"""Simple FunkLoad test
$Id$
"""
import unittest
import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum
from LaPlayaFunkloadHelper import LaPlayaFunkloadHelper


class CPComments(LaPlayaFunkloadHelper):
    """This test uses a configuration file CPShowProjects.conf."""

    def setUp(self):
        LaPlayaFunkloadHelper.setUp(self)

    def test_readonly_view_comment(self):
        server_url = self.server_url
        self.get(server_url, description='View the homepage')
        self.get(server_url + "/projects", description='View the projects index')
        project_url = random.choice(self.listHref(url_pattern='/projects/\d*', content_pattern='Show.*'))
        self.get(server_url + project_url, description='View a project')
        comment_url = random.choice(
            self.listHref(url_pattern='/projects/\d*/comments/\d*', content_pattern='Permalink.*'))
        self.get(server_url + comment_url, description='Show a specific comment')

    def test_create_comment(self):
        server_url = self.server_url
        self.get(server_url, description='View the homepage')
        project_url = random.choice(self.listHref(url_pattern='/projects/\d*'))
        self.get(server_url + project_url, description='View a project')
        leave_a_comment_url = self.listHref(url_pattern='/projects/\d+/comments/new',
                                            content_pattern='Leave a comment.*')
        comment_reply_urls = self.listHref(url_pattern='/projects/\d+/comments/new/\d+', content_pattern='Reply')
        comment_reply_url = random.choice(leave_a_comment_url + comment_reply_urls)
        self.get(server_url + comment_reply_url, description='Load new comment form')

        form_post_url = extract_token(self.getBody(),
                                      '<form accept-charset="UTF-8" action="',
                                      '"')
        comment_parent_id = extract_token(self.getBody(),
                                          '<input id="comment_parent_id" name="comment[parent_id]" type="hidden" value="',
                                          '"')
        params = self.makeParams()
        params += [['comment[text]', Lipsum().getParagraph(length=16)]]
        if comment_parent_id:
            params += [['comment[parent_id]', comment_parent_id]]
        self.post(server_url + form_post_url, params=params, description='Post a new comment')


if __name__ in ('main', '__main__'):
    unittest.main()