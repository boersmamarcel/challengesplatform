#language en
Feature: Security - visitors
  Unauthenticated users should (in some cases) be redirected

  Scenario Outline: Visit a publically visible url as not loggedon visitor
    Given I am not logged in
    When I visit the "<path>" page
    Then I should see the "<page>" page

  Examples: redirects for not logged on visitors
    | path                | page          |
    | home                | index         | 
    | login               | session.new   |


  Scenario Outline: Visit an illegal url as not loggedon visitor
    Given I am not logged in
    When I visit the "<path>" page
    Then I should see the "session.new" page
    And I should get the message "You need to sign in or sign up before continuing."
  
  Examples: Illegal pages
    | path                |
    | dashboard           |
    | challenge.new       |
    | challenges.index    |
    | challenges.pending  |
    | challenges.approved |
    | challenges.declined |
    | challenges.proposal |
    #TODO add more pages, e.g. user homepage, edit account, specific challenge, etc.