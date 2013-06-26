Feature: Revoke challenge
         As a supervisor
		 I want to be able to revoke my challenge

		Scenario: Revoke pending challenge
		Given the following user records
    		| id | email                           | password | password_confirmation  | role  |
   			| 2  | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
   		And the following challenge records
    		| id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
    		| 1   | Title1  | Description1 | next week  | 09-09-2060| pending  | 1     | 2             |
    	When I visit the "login" page
    	And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"
    	And I open the challenge with id "1"    
    	And I follow "Revoke challenge"
    	Then the challenge should have state "Draft"