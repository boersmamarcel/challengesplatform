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
    And I should see a message with "This challenge can't be reviewed"
    
  Scenario: View pending challenge
    When I open the review challenge page for challenge with id "2"
    Then I should see the "admin/review.show" page
  
  @focus
  Scenario Outline: Add comment to pending challenge
    Given I am on the review challenge page for challenge with id "<challenge_id>"
    And I fill in comment with "<comment>"
    And I press "Add comment"
    Then I should see a message with "<message>"
    And I should see the "<page>" page
    
  Examples:
  | challenge_id | comment                  | message                     | page              |
  | 2            | Description is to vague  | Comment successfully added  | admin/review.show |
  | 2            |                          | Comment can not be empty    | admin/review.show |
  
  Scenario: Edit a pending challenge
    Given I am on the review challenge page for challenge with id "2"
    And I press "Edit"
    Then I should see the "admin/review.edit" page
  
  Scenario Outline: Approve/Decline a pending challenge with and without comments
    Given I am on the review challenge page for challenge with id "<challenge_id>"
    And I press "<button>"
    And I fill in comment with "<comment>"
    Then I should see the "<page>" page
    And I should see a message with "<message>"
    
  Examples:
  | challenge_id | button   | comment              | page                | message                                         |
  | 2            | Decline  | To vague please edit | admin/review.index  | Challenge successfully revoked                  |
  | 2            | Decline  |                      | admin/review.show   | Challenge can not be declined without comments  |
  | 2            | Approve  |                      | admin/review.index  | Challenge successfully approved                 |
  
    
  