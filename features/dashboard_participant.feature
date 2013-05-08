@no-txn
Feature: A dashboard for participant
  In order to quickly get up to speed with currently relevant information
  As a participant
  I want to be able to see my challenges, upcoming challenges, notifications,
    and updates of friends on a clear dashboard

  Background:
    Given the following user records
    | id | email                          | password | password_confirmation | role |
    | 1  | supervisor@student.utwente.nl  | abcd1234 | abcd1234              | 1    |
    | 2  | participant@student.utwente.nl | abcd1234 | abcd1234              | 0    |
    When I visit the "login" page
      And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"

  Scenario: View relevant new challenges
      And the following challenge records
      | title              | description        | start_date | end_date   |
      | Save the world     | It's a hit (song)! | next week  | next month |
      | Innovate education | About time.        | next week  | next month |
      | Norvig Award       | We have a winner!  | last week  | next month |

    When I visit the "dashboard" page
    Then I should see "Save the world" in list "Upcoming Challenges"
      And I should see "Innovate education" in list "Upcoming Challenges"
      And I should not see "Norvig Award" in list "Upcoming Challenges"

  Scenario: View my active Challenges
      And the following challenge records
      | title              | description        | start_date | end_date   |
      | Save the world     | It's a hit (song)! | next week  | next month |
      | Innovate education | About time.        | next week  | next month |
      | Norvig Award       | We have a winner!  | last week  | next month |
      | Shark hunting      | Dangerous!         | last year  | last month |

      And I am enrolled in challenge with title "Norvig Award"
      And I am enrolled in challenge with title "Shark hunting"
    When I visit the "dashboard" page
    Then I should see "Norvig Award" in list "My Challenges"
    # Old challenges shouldn't show up
    And I should not see "Shark hunting" in list "My Challenges"
    # My challenges should not come up in Upcoming challenges
    And I should not see "Norvig Award" in list "Upcoming Challenges"

  @wip
  Scenario: View activities of following
      And I'm following "Peter", "Joyce", "Alice" and "Rick"
      And user "Peter" is enrolled in challenge with title "Innovate education"
      And user "Joyce" is enrolled in challenge with title "Save the World"
      And user "Rick" is enrolled in challenge with title "Innovate education"
      And user "Rick" is unenrolled in challenge with title "Innovate education"
    When I visit the "dashboard" page
    Then I should see "Peter and Rick enrolled in the Innovate Education challenge" in list "Activity"
      And I should see "Joyce enrolled in the Save the World challenge" in list "Activity"
      And I should see "Rick unenrolled in the Innovate Education challenge" in list "Activity"
