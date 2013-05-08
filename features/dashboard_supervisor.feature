@no-txn
Feature: A dashboard for supervisor
  In order to quickly get up to speed with currently relevant information
  As a supervisor
  I want to be able to see my challenges, notifications, quickly navigate to enrolled participants or create an announcement for active challenges, and activity updates for my challenges on a clear dashboard

  Scenario: View enrolled participants
    Given I have a challenge named "Innovate education"
      And the following participants are enrolled
      | participant | enroll_date |
      | John | 3 days ago |
      | Finch | 5 days ago |
      | Fusco | 1 week ago |
      And I am logged in as a supervisor
    When I visit the "dashboard" page
      And I click on "view participants" for the challenge
    Then I should see "John" in section "Enrolled Participants"
      And I should see "Fusco" in section "Enrolled Participants"
      And I should not see "Elias" in section "Enrolled Participants"

  Scenario: Make an announcement for a challenge
      Given I have a challenge named "Innovate education"
        And I am logged in as a supervisor
      When I visit the "dashboard" page
        And I click on "make announcement" for the challenge
      Then I should see "Announcement for Innovate education" as a header
        And I should see the "Send" button on the bottom of the form
        And I should see the "message" field in the form
        And I should see the "title" field in the form

  Scenario: One of my challenges ended
      Given I have a challenge named "Innovate education"
        And the end date has been reached
        And I have not yet handed out certificates
        And I am logged in as a supervisor
      When I visit the "dashboard" page
      Then I should see a message with "You need to hand out certificates for some challenges"
        And I should see the "Do now" button below the message

  Scenario: View my challenges
    Given I am logged in as a supervisor
      And I have the following challenges
      | title | description | start_date | end_date | review_passed |
      | Save the world | It's a hit (song)! | next week | next month | no |
      | Innovate education | About time. | next week | next month | yes |
      | Norvig Award | We have a winner! | last week | next month | yes |
      | Shark hunting | Dangerous! | last year | last month | yes |
      And I enrolled for the "Norvig Award" challenge
      And I enrolled for the "Shark hunting" challenge
    When I visit the "dashboard" page
    Then I should see "Norvig Award" in section "Active Challenges"
     And I should see "Save the world" in section "Challenges waiting for review"
     And I should see "Innovate education" in section "Challenges starting soon"
     And I should not see "Shark hunting" in section "Active Challenges"
     And I should not see "Norvig Award" in section "Challenges starting soon"
     And I should see a link for "Past challenges"
