#language en
Feature: Registration 
	Users should be able to request an account

	# View the registration form
	Scenario: Visit the registration url
	Given I am not logged in
	When I visit the "registration.new" page
	Then I should see the "registration.new" page

	# Redirect to the dashboard page
	Scenario: Visit the login page while logged in
	Given I am logged in
	When I visit the "registration.new" page
	Then I should see the "dashboard.index" page
	And I should get the message "You are already signed in."

	# Request account
	Given I am not logged in
	When I visit the "registration.new" page
	And I fill in "user_email" with "interested@example.com"
	And I fill in "user_firstname" with "John"
	And I fill in "user_lastname" with "Doe"
	And I check "tos"
	And I press "Submit"
	Then I should see the "session.new" page
	And I should see a message with "Your request is pending for review. We'll get back to you!"