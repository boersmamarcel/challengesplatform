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

	Scenario: Visit the index page while logged in
		Given I am logged in
		When I visit the "index" page
		Then I should see a message with "Dashboard"

	Scenario: Visit the login page while logged in
		Given I am logged in
		When I visit the "login" page
	  Then I should see the "dashboard.index" page

  Scenario: Login with a not utwente.nl account in Google OAuth
    When I log in with Google "test@gmail.com"
    Then I should see the "index" page
    Then I should see a message with "Only people associated with the University of Twente can sign up. Please sign up with your utwente.nl email address."

	Scenario Outline: For all user types, you can't login twice
		Given the following user records
      | id | email                      	 | password | password_confirmation | role |
      | 1  | admin@student.utwente.nl      | abcd1234 | abcd1234              | 2    |
      | 2  | supervisor@student.utwente.nl | abcd1234 | abcd1234              | 1    |
      | 3  | student@student.utwente.nl    | abcd1234 | abcd1234              | 0    |
		When I visit the "login" page
    And I fill in email with "<role>@student.utwente.nl" and password with "abcd1234"
    And I visit the "login" page
    Then I should see the "dashboard.index" page

    Examples: user roles
    	| role       |
    	| admin      |
    	| supervisor |
    	| student    |
