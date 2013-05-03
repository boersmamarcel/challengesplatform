#language en
Feature: Registration 
	Registration should not be possible

	# Redirect to the login page
	Scenario: Visit the registration url
	Given I am not logged in
	When I visit the "registration.form" page
	Then I should see the "session.new" page
	And I should get the message "We're sorry: only admins are allowed to create new users."

	# Redirect to the dashboard page
	Scenario: Visit the login page while logged in
	Given I am logged in
	When I visit the "registration.form" page
	Then I should see the "dashboard.index" page
