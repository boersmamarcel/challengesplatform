#language en
Feature: Security - students
  Students with insufficient permissions should (in some cases) be redirected

  # Log in as a student user for all upcoming scenarios
  Background:
    Given the following user records
      | id | email                      | password | password_confirmation | role |
      | 1  | student@student.utwente.nl | abcd1234 | abcd1234              | 0    |
    And the following challenge records
      | id | title  | description | start_date | end_date   | state    | count | supervisor_id |
      | 1  | Title1 | Challenge1  | 03-08-2113 | 09-09-2113 | proposal | 1     | 1             |
      | 2  | Title2 | Challenge2  | 03-08-2113 | 09-09-2113 | pending  | 1     | 2             |
      | 3  | Title3 | Challenge3  | 03-08-2113 | 09-09-2113 | approved | 1     | 2             |
    When I visit the "login" page
    And I fill in email with "student@student.utwente.nl" and password with "abcd1234"

  Scenario Outline: Visit legal urls as a student user
    When I visit the "<path>" page
    Then I should see the "<page>" page

  Examples: redirects for students
    | path                  | page            |
    | home                  | index           |
    | login                 | dashboard.index |
    | dashboard             | dashboard.index |
    | challenges.3          | challenge.3    |

  Scenario Outline: Visit illegal urls as a student user (and get redirected)
    When I visit the "<path>" page
    Then I should see the "dashboard" page
    And I should get the message "You do not have the permissions required to view this page."

  Examples: redirects for students
    | path                  |
    | challenges.proposal   |
    | challenges.pending    |
    | challenges.1          |
    | challenges.2          |
    | challenges.1.edit     |
    | challenges.2.edit     |
    | challenges.3.edit     |
    | challenges.new        |
