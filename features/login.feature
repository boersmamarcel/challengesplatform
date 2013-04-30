#language en
Feature: Login
	In order to authenticate myself
	Given the following user records
		| email | password |
		| j.p.balkenende@student.utwente.nl | abcd |
	As a user
	I want to login

	Scenario: Login with correct user credentials
	When I visit the "login" page
	And I fill in email with "j.p.balkenende@student.utwente.nl" and password with "abcd"
	Then I should see the "dashboard" page
	And see the "logout" button

	Scenario: Login with incorrect user credentials
	When I visit the "login" page
	And I fill in email with "j.p.balkenende@studente.utwente.nl" and password with "wrong"
	Then I should see a message with "Wrong password"

	Scenario: Login as a student (with Google OAuth)
	When I log in with Google
	Then I should see the "dashboard" page
	And see the "logout" button	
