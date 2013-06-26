Feature: Delete your own account
		 In order to be able to delete my own account
		 As a user or admin
		 I want to be able to delete my account at the edit user page

	Scenario: As a supervisor I want to be able to delete my account
		Given the following user records
			| id | email                             | password | password_confirmation | active | role |
			| 2  | supervisor@student.utwente.nl 	 | abcd1234 | abcd1234              | true   |	1	|
			| 3  | user@student.utwente.nl 			 | abcd1234 | abcd1234              | true   |	0	|
		And the following challenge records
			| id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
			| 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 2             |
		When I visit the "login" page
		And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234" 
		When I visit the "user.edit" page
		And I press "Cancel my account"
		Then I should see the "index" page
		And the challenges of supervisor with id "1" should be transferred to the default supervisor

	Scenario: As a user I want to be able to delete my account
		Given the following user records
			| id | email                             | password | password_confirmation | active | role |
			| 2  | supervisor@student.utwente.nl 	 | abcd1234 | abcd1234              | true   |	1	|
			| 3  | user@student.utwente.nl 			 | abcd1234 | abcd1234              | true   |	0	|
		When I visit the "login" page
		And I fill in email with "user@student.utwente.nl" and password with "abcd1234" 
		When I visit the "user.edit" page
		And I press "Cancel my account"
		Then I should see the "index" page