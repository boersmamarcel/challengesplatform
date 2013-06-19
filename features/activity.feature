Feature: Activities
  As a user I want to be able to see what the people
  I am following do
  
  Background:
  Given the following user records
  | id | email                          | password | password_confirmation | role |
  | 2  | supervisor@student.utwente.nl  | abcd1234 | abcd1234              | 1    |
  | 3  | participant@student.utwente.nl | abcd1234 | abcd1234              | 0    |
  | 4  | participant2@student.utwente.nl | abcd1234 | abcd1234             | 0    |
  And the following challenge records
  | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
  | 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 2             |
  
  Scenario: someone you follow enrolls for a challenge
    Given "supervisor@student.utwente.nl" is following "participant@student.utwente.nl"
      And I visit the "login" page
      And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
      And I click on the "Title1" link
      And I click on the "Enroll" link
      And I visit the "logout" page
     When I visit the "login" page
      And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"
     Then I should see a message with "is now participating in"
     
  Scenario: someone you follow is now following someone else
    Given "supervisor@student.utwente.nl" is following "participant@student.utwente.nl"
      And I visit the "login" page
      And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
      And I visit the "user.4.profile" page
      And I click on the "Follow" link
      And I visit the "logout" page
     When I visit the "login" page
      And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"
     Then I should see a message with "is now following"