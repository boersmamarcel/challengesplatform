#language en
Feature: Usermanagement
  Admins should be given an overview of all users + options

  # Log in as an admin user for all upcoming scenarios
  Background:
    Given the following user records
     | id | firstname | lastname | email            | password | password_confirmation | role |
     | 1  | Keven     | Flyn     | admin@ut.nl      | abcd1234 | abcd1234              | 2    |
     | 2  | Tron      | Flyn     | supervisor@ut.nl | abcd1234 | abcd1234              | 1    |
     | 3  | Rinzler   | Flyn     | student@ut.nl    | abcd1234 | abcd1234              | 0    |
    And the following challenge records
      | id | title  | description | start_date | end_date   | state    | count | supervisor_id |
      | 1  | Title1 | Challenge1  | 03-08-2113 | 09-09-2113 | proposal | 1     | 1             |
      | 2  | Title2 | Challenge2  | 03-08-2113 | 09-09-2113 | pending  | 1     | 2             |
      | 3  | Title3 | Challenge3  | 03-08-2113 | 09-09-2113 | approved | 1     | 2             |
    And the following message records
      | id | subject             | body                             | sender_id | receiver_id | is_read |
      | 1  | Test message        | This is a test message           | 1         | 1           | 0       |
    When I visit the "login" page
    And I fill in email with "admin@ut.nl" and password with "abcd1234"

  Scenario: Visit the user overview
  When I visit the "admin/usermanagement.index" page
  Then I should see the "admin/usermanagement.index" page
  And I should see a button "mail"
  And I should see a button "delete"