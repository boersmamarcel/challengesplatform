#language en
Feature: Registration
	In order to create an account
	Given the following user records
		| email | password |
		| j.p.balkenende@student.utwente.nl | abcd |
	As a future-user
	I want to be able to register

	Scenario Outline: Registration
		When I visit register
		And I press "Login with Google"
		And have email 
		Then I should see
