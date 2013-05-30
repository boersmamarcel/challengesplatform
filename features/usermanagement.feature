#language en
Feature: Usermanagement
  Admins should be given an overview of all users + options

  # Log in as an admin user for all upcoming scenarios
  Background:
    Given the following user records
     | id | firstname | lastname | email            | password | password_confirmation | role |
     | 1  | Kevin     | Flyn     | admin@ut.nl      | abcd1234 | abcd1234              | 2    |
     | 2  | Abraxis   | Flyn     | abraxis@ut.nl    | abcd1234 | abcd1234              | 1    |
     | 3  | Rinzler   | Flyn     | student@ut.nl    | abcd1234 | abcd1234              | 0    |
     | 4  | Tron      | Flyn     | tron@ut.nl       | abcd1234 | abcd1234              | 1    |
    And the following challenge records
      | id | title  | description | start_date | end_date   | state    | count | supervisor_id |
      | 1  | Title1 | Abraxis'    | 03-08-2113 | 09-09-2113 | proposal | 1     | 2             |
      | 2  | Title2 | Tron's      | 03-08-2113 | 09-09-2113 | pending  | 1     | 4             |
      | 3  | Title3 | Abraxis'    | 03-08-2113 | 09-09-2113 | approved | 1     | 2             |
    And the following message records
      | id | subject             | body                             | sender_id | receiver_id | is_read |
      | 1  | Test message        | This is a test message           | 1         | 1           | 0       |
    When I visit the "login" page
    And I fill in email with "admin@ut.nl" and password with "abcd1234"

  Scenario: Visit the user overview
    When I visit the "admin/usermanagement.index" page
    Then I should see the "admin/usermanagement.index" page
    And I should see a link with title "message Abraxis"
    And I should see a link with title "delete Abraxis"
    And I should see a link with title "message Rinzler"
    And I should see a link with title "delete Rinzler"
    And I should see a link with title "message Tron"
    And I should see a link with title "delete Tron"
    And I should not see a link with title "message Kevin"
    And I should not see a link with title "delete Kevin"

  Scenario: Delete a user
    When I visit the "admin/usermanagement.index" page
    And I click on the link with title "delete Abraxis"
    And I click on the link with title "delete Rinzler"
    Then I should not see a link with title "delete Abraxis"
    And I should not see a link with title "delete Rinzler"
    And I should see a link with title "delete Tron"

  Scenario: Edit a user
    When I visit the "admin/usermanagement.index" page
    And I click on the link with title "edit Abraxis"
    Then I should see the "admin/users.2.edit" page

  Scenario: Edit yourself
    When I visit the "admin/usermanagement.index" page
    And I click on the link with title "edit Kevin"
    Then I should see the "registrations.edit" page

  Scenario: Promote a supervisor to admin
    When I visit the "admin/users.2.edit" page
    And I select "admin" from the "role" dropdown
    And I click on the button with title "Update"
    Then I should see the "admin/usermanagement.index" page
    And user Abraxis should have "admin" as role

  Scenario: Demote a supervisor to student
    When I visit the "admin/users.2.edit" page
    And I select "student" from the "role" dropdown
    And I click on the button with title "Update"
    Then I should see the "admin/usermanagement.index" page
    And user Abraxis should have "student" as role