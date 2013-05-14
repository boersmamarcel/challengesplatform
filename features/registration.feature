#language en
Feature: Registration 
	Registration should not be possible

	# Redirect to the login page
	Scenario: Visit the registration url
	Given I am not logged in
	When I visit the "registration.form" page
	Then I should see the "session.new" page
	And I should get the message "You need to sign in or sign up before continuing."

	# Redirect to the dashboard page
	Scenario: Visit the login page while logged in
	Given I am logged in
	When I visit the "registration.form" page
	Then I should see the "dashboard.index" page
	And I should get the message "You do not have the permissions required to view this page."