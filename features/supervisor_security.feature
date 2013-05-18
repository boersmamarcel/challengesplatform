# Summarized challenge rw policy;
# You can always see your own challenge
# Your view rights for other challenges equal that of students (only approved)
# You can only edit you own challenges, and only if they are proposals

#language en
Feature: Security - supervisors
  Supervisors with insufficient permissions should (in some cases) be redirected

  # Log in as a supervisor user for all upcoming scenarios
  Background:
    Given the following user records
      | id | email                         | password | password_confirmation | role |
      | 1  | supervisor@student.utwente.nl | abcd1234 | abcd1234              | 1    |
    And the following challenge records
      | id | title  | description | start_date | end_date   | state    | count | supervisor_id |
      | 1  | Title1 | Challenge1  | 03-08-2113 | 09-09-2113 | proposal | 1     | 1             |
      | 2  | Title2 | Challenge2  | 03-08-2113 | 09-09-2113 | pending  | 1     | 1             |
      | 3  | Title3 | Challenge3  | 03-08-2113 | 09-09-2113 | approved | 1     | 1             |
      | 4  | Title4 | Challenge4  | 03-08-2113 | 09-09-2113 | proposal | 1     | 2             |
      | 5  | Title5 | Challenge5  | 03-08-2113 | 09-09-2113 | pending  | 1     | 2             |
      | 6  | Title6 | Challenge6  | 03-08-2113 | 09-09-2113 | approved | 1     | 2             |
    And the following message records
      | id | subject             | body                             | sender_id | receiver_id | is_read |
      | 1  | Test message        | This is a test message           | 1         | 1           | 0       |
    When I visit the "login" page
    And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"

  Scenario Outline: Visit legal urls as a supervisor user
    When I visit the "<page>" page
    Then I should see the "<page>" page

  Examples: allowed paths for supervisors
    | page                |
    | index               |
    | dashboard.index     |
    | challenges.1        |
    | challenges.2        |
    | challenges.3        |
    | challenges.6        |
    | challenges.1.edit   |
    | challenge.new       |
    | user.1.profile      |
    | messages.1          |

  Scenario Outline: Visit illegal urls as a supervisor user (and get redirected)
    When I visit the "<path>" page
    Then I should see the "<page>" page
    And I should get the message "You do not have the permissions required to view this page."

  Examples: redirects for supervisor
    | path              | page            |
    | challenges.2.edit | challenges.2    |
    | challenges.3.edit | challenges.3    |
    | challenges.4.edit | dashboard.index |
    | challenges.5.edit | dashboard.index |
    | challenges.6.edit | challenges.6    |
