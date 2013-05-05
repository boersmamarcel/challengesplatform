Feature: A dashboard for users
  In order to quickly get up to speed with currently relevant information
  As a student or supervisor
  I want to be able to see my challenges, upcoming challenges, notifications, and updates of friends on a clear dashboard

  Scenario: View relevant new challenges
    Given the following challenge records
      | title | description | start_date | end_date |
      | Save the world | It's a hit (song)! | next week | next month |
      | Innovate education | About time. | next week | next month |
      | Norvig Award | We have a winner! | last week | today |
      And I am logged in
    When I visit the the "dashboard" page
    Then I should see "Save the World"
      And I should see "Innovate education"
      And I should not see "Norvig Award"
