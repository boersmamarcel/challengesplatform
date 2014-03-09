Feature: Search
  As a user I want to be able to search

  Background:
  Given I am logged in

  @search
  @javascript
  Scenario: search a user
    Given the following user records
      | id | email            | firstname  | role | active |
      | 2  | foobarUser@a.com | foobaruser | 0    | true   |
    When I visit the "search.index" page
     And I enter "foo" in search-full-query
    Then the page should have content "foobaruser"

  @search
  @javascript
  Scenario: search for non-existing user
    Given the following user records
      | id | email            | firstname  | role | active |
      | 2  | foobarUser@a.com | foobaruser | 0    | true   |
    When I visit the "search.index" page
     And I enter "notexistinguser" in search-full-query
    Then the page should have content "Your search did not match any results."
  
  @search
  @javascript
  Scenario: filter all results away
    Given the following user records
      | id | email            | firstname  | role | active |
      | 2  | foobarUser@a.com | foobaruser | 0    | true   |
    When I visit the "search.index" page
     And I enter "foo" in search-full-query
     And I press the "#filter-challenges" button
    Then the page should have content "No results with the current filter. Consider showing all results..."

  @search
  @javascript
  Scenario: filter all results away
    Given the following user records
      | id | email            | firstname  | role | active |
      | 2  | foobarUser@a.com | foobaruser | 1    | true   |
    And the following challenge records
      | id  | title           | lead      | description    | start_date | end_date   | state    | supervisor_id |
      | 1   | foobarChallenge | some lead | some challenge | next week  | next month | approved | 2             |
    When I visit the "search.index" page
     And I enter "foo" in search-full-query
     And I press the "#filter-challenges" button
    Then the page should have content "foobarChallenge"
     And the page should not have content "foobarUser"

  @search
  @javascript
  Scenario: search pages (inbox)
    When I visit the "search.index" page
     And I enter "inb" in search-full-query
    Then the page should have content "Inbox"
     And the page should have content "Message inbox; view all your messages"

  @search
  @javascript
  Scenario: search pages (challenges)
    When I visit the "search.index" page
     And I enter "chal" in search-full-query
    Then the page should have content "Challenges"
     And the page should have content "An overview of all challenges"
