#language en
Feature: User adding
  Admins should be given the opportunity to add users to the system

  # Log in as an admin user for all upcoming scenarios
  Background:
    Given the following user records
     |id| firstname | lastname | tagline | email                  | password | password_confirmation | role | active |
     |2 | sciencechallenges |- | I'm the boss | challenge@localhost.nl | abcd1234 | abcd1234              | 1    | false  |
     |3 | Kevin     | Flyn     | Running this madness | admin@ut.nl            | abcd1234 | abcd1234              | 2    | true   |
    When I visit the "login" page
    And I fill in email with "admin@ut.nl" and password with "abcd1234"

  Scenario: Access the add user page
    When I visit the "admin/usermanagement.index" page
    And I click on the link with title "Add user"
    Then I should see the "admin/users.new" page

  Scenario: Add a user
    When I visit the "admin/users.new" page
    And I enter "John" in user_firstname
    And I enter "Doe" in user_lastname
    And I enter "I'm a student" in user_tagline
    And I enter "johndoe@example.com" in user_email
    And I select "supervisor" from the "user_role" dropdown
    And I click on the button with title "Save user"
    Then I should see the "admin/usermanagement.index" page
    And user John should have "Doe" as lastname
    And user John should have "johndoe@example.com" as email
    And user John should have "active" as state

  Scenario: Add a user with a duplicate email
    When I visit the "admin/users.new" page
    And I enter "John" in user_firstname
    And I enter "Doe" in user_lastname
    And I enter "admin@ut.nl" in user_email
    And I click on the button with title "Save user"
    Then I should see the "admin/users.new" page
    And I should see a message with "Email has already been taken"
