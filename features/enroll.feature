@no-txn
Feature: Participants can enroll for challenges
         In order to enroll for a challenge
         As an user
         I want to be able to view the challenge and press enroll

  Background:
    Given the following user records
    | id | email                           | password | password_confirmation  | role  |
    | 2  | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
    | 3  | participant@student.utwente.nl  | abcd1234 | abcd1234               | 0     |
    And the following challenge records
    | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
    | 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 2             |
    | 2   | Title2  | Description2 | 09-09-2059 | 09-09-2060| pending  | 2     | 2             |
    | 3   | Title3  | Description3 | 09-09-2059 | 09-09-2060| draft    | 1     | 2             |
    | 4   | Title4  | Description4 | 09-09-2059 | 09-09-2060| draft    | 4     | 2             |
    | 5   | Title5  | Description5 | next month | 09-09-2060| approved | 2     | 2             |
    | 6   | Title6  | Description6 | 09-09-2059 | 09-09-2060| approved | 2     | 2             |
    | 7   | Title7  | Description7 | 15-05-2013 | 09-09-2060| approved | 2     | 2             |
    When I visit the "login" page
    And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"


  Scenario: View all challenges
    When I visit the "challenges.index" page
    And I should see a title "Title1" and start_date "next week" and end_date "09-09-2060" in the list
    # And I should see a title "Title7" and start_date "15-05-2013" and end_date "09-09-2060" in the list


  Scenario Outline: View a challenge
    When I open the challenge with id "<challenge_id>"
    Then I should see a title "<title>" and description "<description>" and start_date "<start_date>" and end_date "<end_date>"
    And I should see a button "<buttons>"

  Examples:
  |   challenge_id    | title   | description  |  buttons     | start_date | end_date  |
  |   6               | Title6  | Description6 |  Enroll      | 09-09-2059 | 9-09-2060 |

  Scenario: Subscribe to a challenge before start date
    When I open the challenge with id "1"
    And I follow "Enroll"
    Then I should see a message with "Successfully enrolled"

  Scenario: Subscribe to a challenge after start date
    When I open the challenge with id "7"
    Then I should see a message with "Enrollment has closed"
    And I should not see button "Enroll"

  Scenario Outline: Unsubscribe from a challenge
    Given user "participant@student.utwente.nl" is enrolled in challenge "<challenge_id>"
    When I open the challenge with id "<challenge_id>"
    And I follow "Unenroll"
    Then I should see a message with "Successfully unenrolled"

  Examples:
  | challenge_id |
  | 1            |
  | 5            |


  Scenario Outline: View challenge with state
    When I open the challenge with id "<challenge_id>"
    Then I should see the "<redirect>" page

  Examples:
  | challenge_id      |  redirect          |
  | 3                 |  dashboard.index   |
  | 2                 |  dashboard.index   |
  | 4                 |  dashboard.index   |
