Feature: Review challenges as admin
  In order to review challenges
  As an admin
  I want to be able to view 'pending for review' challenges 
  And I want be able to add comments to a challenge
  And I want to be able to edit the challenge
  And I want to be able to approve the challenge
  And I want to be able to decline the challenge
  
  Background:
    Given the following user records
    |id | firstname | lastname | email | password | password_confirmation | role |
    | 1 | Marcel | Boersma | m.boersma-1@student.utwente.nl | pass123456 | pass123456 | 2 |
    | 2 | Bas    | Veeling | b.veeling@student.utwente.nl | pass123456 | pass123456 | 1 |
    | 3 | Bram | Leenders | b.leenders@student.utwente.nl | pass123456 | pass123456 | 0 |
    And the following challenge records
    | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
    | 1 | Awesome challenge | This is an awesome challenge | next week | next month | pending | 1 | 2 |
    | 2 | Not so awesome challenge | This is not so awesome | next week | next month | pending | 2 |  2 |
    | 3 | Not pending challenge | this is a challenge description | next week | next month | proposal | 2 | 2 |
    When I visit the "login" page
    And I fill in email with "m.boersma-1@student.utwente.nl" and password with "pass123456"
  
  Scenario: View pending challenges
    When I visit the "admin/review.index" page
    Then I should see "Awesome challenge" in the list
    And I should see "Not so awesome challenge" in the list
    And I should not see "Not pending challenge" in the list
  
  Scenario: View a challenge in non pending state
    When I open the review challenge page for challenge with id "3"
    Then I should see the "admin/review.index" page
    And see a message with "This challenge can't be reviewed"
    
  Scenario: View pending challenge
    When I open the review challenge page for challenge with id "2"
    Then I should see the "admin/review.show" page
  
  Scenario: Add comment to pending challenge
    Given I am on the review challenge page for challenge with id "2"
    And I fill in comment with "Description is to vague"
    And I press "Add comment"
    Then I should see a message with "Comment successfully added"
    And I should see the "admin/review.show" page
  
  Scenario: Add empty comment to pending challenge
    Given I am on the review challenge page for challenge with id "2"
    And I fill in comment with ""
    And I press "Add comment"
    Then I should see a message with "Comment can not be empty"
    And I should see the "admin/review.show" page
  
  Scenario: Edit a pending challenge
    Given I am on the review challenge page for challenge with id "2"
    And I press "Edit"
    Then I should see the "admin/review.edit" page
  
  Scenario: Approve a pending challenge
    Given I am on the review challenge page for challenge with id "2"
    And I press "Approve"
    Then I should see the "admin/review.index" page
    And I should see a message with "Challenge successfully approved"
  
  Scenario: Decline a pending challenge and add comments
    Given I am on the review challenge page for challenge with id "2"
    And I press "Decline"
    And I fill in comment with "To vague please edit"
    Then I should see the "admin/review.index" page
    And I should see a message with "Challenge successfully revoked"
  
  Scenario: Decline a pending challenge and don't add any comments