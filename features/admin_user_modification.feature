#language en
Feature: User modification
         In order to modify a user
         As an admin
         I want to be able to change user details and save them

  # Log in as an admin user for all upcoming scenarios
  Background:
    Given the following user records
     |id| firstname | lastname | email                  | password | password_confirmation | role | active |
     |2 | John      | Doe      | johndoe@localhost.nl   | abcd1234 | abcd1234              | 0    | true   |
     |3 | Kevin     | Flyn     | admin@ut.nl            | abcd1234 | abcd1234              | 2    | true   |
    When I visit the "login" page
    And I fill in email with "admin@ut.nl" and password with "abcd1234"

    Scenario: change user lastname to empty string
    When I visit the "admin/usermanagement.index" page
     And I click on the link with title "edit John"
     And I fill in "user[lastname]" with ""
     And I press "Save user"
    Then I should see a message with "Last name is missing"