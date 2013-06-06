Feature: public challenges page
		In order to view challenges
		As a guest user
		I want to be able to see the challenge

	Background:
    	Given the following user records
    	| id | email                           | password | password_confirmation  | role  |
    	| 2	 | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
    	| 3	 | supervisor2@student.utwente.nl  | abcd1234 | abcd1234               | 1     |
    	And the following challenge records
	    | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
	    | 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 2             |

	Scenario: Visit a challenge page
		When I open the challenge with id "1"
		Then the page should have content "Title1"
		And the page should have content "Description1"
		And I should not see a link "Enroll"
		And I should see a link "Sign in"
