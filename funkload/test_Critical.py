# -*- coding: iso-8859-15 -*-
"""Simple FunkLoad test
$Id$
"""
import unittest
from random import random
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import extract_token
from funkload.Lipsum import Lipsum


class Critical(FunkLoadTestCase):
    """This test use a configuration file Simple.conf."""

    def setUp(self):
      """Setting up test."""
      self.server_url = self.conf_get('main', 'url')

    def test_critical_path(self):
	server_url = self.server_url
	self.get(server_url, description='Get root URL')
	self.get(server_url + "/users/sign_up", description="View the user signup page")

	auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')
	email = Lipsum().getUniqWord() + "@" + Lipsum().getWord() + ".com"

	self.post(self.server_url + "/users",
	    params=[['user[email]', email],
	      ['user[password]', 'alphabet'],
	      ['user[password_confirmation]', 'alphabet'],
	      ['authenticity_token', auth_token],
	      ['commit', 'Sign up']],
	    description="Create New User")

	self.get(server_url + "/challenges/new", description="View the new challenges page")
	auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')

	challenge_name = Lipsum().getSentence()
	self.post(self.server_url + "/challenges",
	    params=[['challenge[name]', challenge_name],
	      ['authenticity_token', auth_token],
	      ['commit', 'Create challenge']],
	    description="Create New challenge")
	last_url = self.getLastUrl()

	created_challenge_id = last_url.split('/')[-1]
	self.get(server_url + "/challenges/"+created_challenge_id, description="View the created challenge page")

	self.get(server_url + "/progresses/new", description="View the new progresses page")
	auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')

	progress_title = Lipsum().getSentence()
	progress_url = "http://www."+Lipsum().getWord() + Lipsum().getUniqWord() + ".com/"
	self.post(self.server_url + "/progresses",
	    params=[['progress[title]', progress_title],
	      ['progress[url]', progress_url],
	      ['progress[challenge_id]', created_challenge_id],
	      ['authenticity_token', auth_token],
	      ['commit', 'Create progress']],
	    description="Create New progress")
	last_url = self.getLastUrl()
	created_progress_id = last_url.split('/')[-1]

	self.get(server_url + "/comments/new", description="View the new comments page")
	auth_token = extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value="', '"')

	comment_message = Lipsum().getSentence()
	comment_parent = ''
	progress_id = created_progress_id
	self.post(self.server_url + "/comments",
	    params=[['comment[message]', comment_message],
	      ['comment[progress_id]', progress_id],
	      ['comment[parent_id]', comment_parent],
	      ['authenticity_token', auth_token],
	      ['commit', 'Create Comment']],
	    description="Create New Comment")


    def test_critical_path_readonly(self):
		server_url = self.server_url
		self.get(server_url, description='View root URL')
		self.get(server_url + "/users/sign_up", description="View the user signup page")
	
		auth_token= extract_token(self.getBody(), 'name="authenticity_token" type="hidden" value"','"')
		email=Lipsum().getUniqWord+"@"+Lipsum().getWord()+".com"
		name =Lipsum().getUniqWord

		self.post(self.server_url +"/users",
			params=[['user[name]', name],
			['user[email]', email],
			['user[password]', 'alphabet'],
			['user[password_confirmation]', auth_token],
			['commit','Sign up']],
			description="Create New User")

		self.get(server_url + "/challenges/", description="View the challenges page")


if __name__ in ('main', '__main__'):
  unittest.main()