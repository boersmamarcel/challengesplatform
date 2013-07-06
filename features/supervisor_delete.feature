Feature: A supervisor should be able to delete itself
		In order to delete myself
		As a supervisor
		I want to be able to Destroy my account

		Scenario: Delete supervisor
			Given the following user records
			  	|id| firstname | lastname | email                  | password | password_confirmation | role | active |
     			|1 | sciencechallenges |- | challenge@localhost.nl | abcd1234 | abcd1234              | 1    | false  |
     			|2 | Kevin     | Flyn     | super@ut.nl            | abcd1234 | abcd1234              | 1    | true   |
     		When I visit the "login" page
    		And I fill in email with "super@ut.nl" and password with "abcd1234"
    		And I visit the "user.edit" page
    		And I press "Destroy my account"
    		Then I should see the "index" page