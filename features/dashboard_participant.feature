Feature: A dashboard for participant
  In order to quickly get up to speed with currently relevant information
  As a participant
  I want to be able to see my challenges, upcoming challenges, notifications, and updates of friends on a clear dashboard

  Scenario: View relevant new challenges
    Given the following challenge records
      | title | description | start_date | end_date |
      | Save the world | It's a hit (song)! | next week | next month |
      | Innovate education | About time. | next week | next month |
      | Norvig Award | We have a winner! | last week | next month |
      And I am logged in as a participant
    When I visit the "dashboard" page
    Then I should see "Save the World" in section "Upcoming Challenges"
      And I should see "Innovate education" in section "Upcoming Challenges"
      And I should not see "Norvig Award" in section "Upcoming Challenges"

  Scenario: View my active Challenges
    Given I am logged in as a participant
      And the following challenge records
      | title | description | start_date | end_date |
      | Save the world | It's a hit (song)! | next week | next month |
      | Innovate education | About time. | next week | next month |
      | Norvig Award | We have a winner! | last week | next month |
      | Shark hunting | Dangerous! | last year | last month |
      And I enrolled for the "Norvig Award" challenge
      And I enrolled for the "Shark hunting" challenge
    When I visit the "dashboard" page
    Then I should see "Norvig Award" in section "My Current Challenges"
    And I should not see "Shark hunting" in section "My Current Challenges"
    And I should not see "Norvig Award" in section "Upcoming Challenges"

  Scenario: View activities of friends
    Given I am logged in as a participant
      And I'm friends with "Peter", "Joyce", "Alice" and "Rick"
      And "Peter" enrolled for the "Innovate education" challenge
      And "Joyce" enrolled for the "Save the World" challenge
      And "Rick" enrolled for the "Innovate education" challenge
      And "Rick" unenrolled for the "Innovate education" challenge
    When I visit the "dashboard" page
    Then I should see "Peter and Rick enrolled for the Innovate Education challenge" in secion "Activity"
      And I should see "Joyce enrolled for the Save the World challenge" in secion "Activity"
      And I should see "Rick unenrolled for the Innovate Education challenge" in secion "Activity"
