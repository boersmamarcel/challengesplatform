#language en
Feature: Login
	In order to authenticate myself
	As a user
	I want to login

  Scenario: Login with correct user credentials
	Given the following user records
		| email | password | password_confirmation |
		| j.p.balkenende@student.utwente.nl | abcd1234 | abcd1234 |
	When I visit the "login" page
	And I fill in email with "j.p.balkenende@student.utwente.nl" and password with "abcd1234"
	Then I should see the "dashboard.index" page

	Scenario: Login with incorrect user credentials
	Given the following user records
		| email | password | password_confirmation |
		| j.p.balkenende@student.utwente.nl | abcd1234 | abcd1234 |
	When I visit the "login" page
	And I fill in email with "j.p.balkenende@studente.utwente.nl" and password with "wrong"
	Then I should see a message with "Invalid email or password"

	Scenario: Login as a student (with Google OAuth)
	When I log in with Google "test@utwente.nl"
	Then I should see the "dashboard.index" page

	Scenario: Visit the home page while logged in
	Given I am logged in
	When I visit the "home" page
	Then I should see a message with "Go to dashboard" 

	Scenario: Visit the login page while logged in
	When I am logged in
	And I visit the "login" page
  Then I should see the "dashboard.index" page


  #temporary scenario:
  Scenario: Login with a not utwente.nl account in Google OAuth
      When I log in with Google "test@gmail.com"
      Then I should see the "index" page 
