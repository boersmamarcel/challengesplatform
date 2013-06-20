Feature: Supervisor review pipeline
         In order to edit a challenge after a review
         As a supervisor
         I want to be able to see the comments on my challenge, add comments to my challenge and resubmit my draft.


    Background:
    	Given the following user records
    	| id | email                           | password | password_confirmation  | role  |
    	| 2	 | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
    	| 3	 | supervisor2@student.utwente.nl  | abcd1234 | abcd1234               | 1     |
    	And the following challenge records
	    | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
	    | 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 2             |
	    | 2   | Title2  | Description2 | 09-09-2059 | 09-09-2060| pending  | 2     | 2             |
	    | 3   | Title3  | Description3 | 09-09-2059 | 09-09-2060| draft    | 1     | 2             |
	    | 4   | Title4  | Description4 | 09-09-2059 | 09-09-2060| draft    | 4     | 3             |
	    | 5   | Title5  | Description5 | next month | 09-09-2060| draft    | 2     | 2             |
	    | 6   | Title6  | Description6 | 09-09-2059 | 09-09-2060| approved | 2     | 2             |
	    | 7   | Title7  | Description7 | 15-05-2013 | 09-09-2060| approved | 2     | 2             |
	    And I visit the "login" page
	    And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"

    Scenario: Supervisor views a draft challenge
    	When I open the challenge with id "3"
    	Then I should see a link "Edit"
    	And I should see a button "Submit for Review"

    Scenario: Supervisor views a declined challenge
    	When I open the challenge with id "5"
    	Then I should see a link "Edit"
    	And I should see a button "Resubmit for Review"

    Scenario: Supervisor views a pending challenge
    	When I open the challenge with id "2"
    	Then I should not see a button "Submit for Review"
    	And I should not see a button "Resubmit for Review"

    Scenario: Supervisor views an approved challenge
    	When I open the challenge with id "1"
    	Then I should not see a button "Submit for Review"
    	And I should not see a button "Resubmit for Review"

    Scenario: Supervisor views a draft challenge of another supervisor
    	When I open the challenge with id "4"
    	Then I should not see a button "Submit for Review"
    	And I should not see a button "Resubmit for Review"
    	And I should not see a link "Edit"

    Scenario: Supervisor adds comment to draft challenge
    	When I open the challenge with id "3"
    	And I fill in comment with "This is a test comment"
    	And I press "Add comment"
    	Then the page should have content "This is a test comment" 

    Scenario: Supervisor resubmits a challenge for the next review
    	When I open the challenge with id "5"
    	And I press "Resubmit for Review"
    	Then the page should have content "pending"

  Scenario Outline: View the message corresponding to a challenge
    When I visit the "challenges.<id>" page
    Then I should see a message with "<message>"

    Examples:
    |id | message                                           |
    | 3 | Your challenge is still a draft.                  |
    | 5 | Your challenge submission needs some work!        |
    | 2 | Your challenge is pending for review.             |
    | 7 | Your challenge submission is approved, great job! |