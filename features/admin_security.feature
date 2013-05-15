#language en
Feature: Security - supervisor
  Admins should never be redirected

  # Log in as an admin user for all upcoming scenarios
  Background:
    Given the following user records
      | id | email                      | password | password_confirmation | role |
      | 1  | admin@student.utwente.nl   | abcd1234 | abcd1234              | 2    |
    And the following challenge records
      | id | title  | description | start_date | end_date   | state    | count | supervisor_id |
      | 1  | Title1 | Challenge1  | 03-08-2113 | 09-09-2113 | proposal | 1     | 1             |
      | 2  | Title2 | Challenge2  | 03-08-2113 | 09-09-2113 | pending  | 1     | 2             |
      | 3  | Title3 | Challenge3  | 03-08-2113 | 09-09-2113 | approved | 1     | 2             |
    When I visit the "login" page
    And I fill in email with "admin@student.utwente.nl" and password with "abcd1234"    

  Scenario Outline: Visit any url as an admin user, and get to see it
    And I visit the "<page>" page
    Then I should see the "<page>" page

  Examples: allowed urls for admins
    | page              |
    | index             |
    | dashboard.index   |
    | challenges.1      |
    | challenges.2      |
    | challenges.3      |
    | challenges.1.edit |
    | challenges.2.edit |
    | challenges.3.edit |
    | challenge.new     |
    | user.1.profile    |