Feature: An admin must at all times be able to edit/revoke a challenge
		As an admin
		I want to be able to edit/revoke challenges

	Background:
	Given the following user records
    | id | email                           | password | password_confirmation  | role  |
    | 3  | admin@student.utwente.nl        | abcd1234 | abcd1234               | 2     |
    | 2  | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
    And the following challenge records
    | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
    | 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 2             |
    | 2   | Title2  | Description2 | 09-09-2059 | 09-09-2060| pending  | 2     | 2             |
    | 3   | Title3  | Description3 | 09-09-2059 | 09-09-2060| draft    | 1     | 2             |
    | 4   | Title4  | Description4 | 09-09-2059 | 09-09-2060| draft    | 4     | 2             |
    When I visit the "login" page
    And I fill in email with "admin@student.utwente.nl" and password with "abcd1234"

	Scenario: Edit approved challenge
	When I open the challenge with id "1"    
	Then I should see a link "Revoke challenge"
	And I should see a link "Edit"
	And I follow "Edit"
	Then I should see the "challenges.1.edit" page

	Scenario: Edit draft challenge
	When I open the challenge with id "3"    
	Then I should not see a link "Revoke challenge"
	And I should see a link "Edit"
	And I follow "Edit"
	Then I should see the "challenges.3.edit" page

	Scenario: Revoke approved challenge
	When I open the challenge with id "1"    
	And I follow "Revoke challenge"
	Then I should see a message with "Challenge successfully revoked"

	Scenario: Revoke pending challenge
	When I open the challenge with id "2"    
	Then I should not see a link "Revoke challenge"
	And I should see a link "Edit"

	Scenario: Revoke draft challenge
	When I open the challenge with id "3"    
	Then I should not see a link "Revoke challenge"
	And I should see a link "Edit"

	Scenario: Revoke declined challenge
	When I open the challenge with id "4"    
	Then I should not see a link "Revoke challenge"
	And I should see a link "Edit"