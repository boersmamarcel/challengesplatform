Feature: Filtering challenges
  In order to easily browse challenges
  I want to be able to filter them
  
  Background:
  Given the following user records
  | id | email                          | password | password_confirmation | role |
  | 2  | supervisor@student.utwente.nl  | abcd1234 | abcd1234              | 1    |
  | 3  | participant@student.utwente.nl | abcd1234 | abcd1234              | 0    |
  And the following challenge records
  | id  | title       | description  | start_date | end_date  | state        | count | supervisor_id |
  | 1   | Uptown!     | Description1 | next week  | 09-09-2060| approved     | 1     | 2             |
  | 2   | Run Forest! | Description1 | last week  | 09-09-2060| approved     | 1     | 2             |
  | 3   | Long gone!  | Description1 | last month | last week | approved     | 1     | 2             |
  
  Scenario: Viewing upcoming challenges
  Given I visit the "login" page
    And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
   When I visit the "challenges.upcoming" page
   Then I should see a message with "Uptown!"
   
   Scenario: Viewing running challenges
   Given I visit the "login" page
     And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
    When I visit the "challenges.running" page
    Then I should see a message with "Run Forest!"
    
    Scenario: Viewing past challenges
    Given I visit the "login" page
      And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
     When I visit the "challenges.past" page
      And I should see a message with "Long gone!"
     
   Scenario: Viewing supervising challenges as participant
   Given I visit the "login" page
     And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
    When I visit the "challenges.supervising" page
    Then I should be on the "challenges.index" page
    
   Scenario: Viewing supervising challenges as supervisor
   Given I visit the "login" page
     And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"
    When I visit the "challenges.supervising" page
    Then I should see a message with "Run Forest!"
     And I should see a message with "Uptown!"
     And I should see a message with "Long gone!"
     
   Scenario: Viewing enrolled challenges
   Given I visit the "login" page
     And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
     And I visit the "challenges.1" page
     And I click on the "Enroll" link
    When I visit the "challenges.enrolled" page
    Then I should see a message with "Uptown!"