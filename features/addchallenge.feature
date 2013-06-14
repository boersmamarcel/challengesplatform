Feature: Add challenge
    In order to add challenges
    As an admin or supervisor
    I want to be able to submit a draft for review and see the current stats of an approved challenge

    Background:
      Given the following user records
        | id | email                           | password | password_confirmation  | role  |
  	    | 1  | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
      When I visit the "login" page
  	  And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"

    Scenario Outline: Submit new challenge
      When I visit the "challenges.index" page
      And I follow "Create a challenge"
      And I fill in title with "<title>" and description with "<description>" and fill in start_date with "<start_date>" and end_date with "<end_date>" and lead with "<lead>" and commitment with "5" and image with "<image>"
      And I press "Submit for Review"
      # Then show me the page
      Then I should see a message with "<message>"

    Examples:
      |  title  | description           | start_date | end_date   | message                               | lead | image |
      | Title 1 | Challenge description | 03-08-2013 | 09-09-2013 | Challenge is pending for review       | Aenean mattis tellus ac urna suscipit quis tempor nisi fringilla. | image1.jpg |
      | Title 1 | Challenge description | 03-08-2013 | 09-09-2013 | Lead is too short                     | Short |  image2.jpg |
      | Title 1 | Challenge description | 03-08-2013 | 09-09-2013 | Lead is too long                      | Loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong |  image3.jpg |
      | Title 1 | Challenge description | 09-09-2013 | 03-08-2013 | End date can not be before start date | Aenean mattis tellus ac urna suscipit quis tempor nisi fringilla. |  image4.jpg |
      | Title 1 |                       | 03-08-2013 | 09-09-2013 | One or more fields are missing        | Aenean mattis tellus ac urna suscipit quis tempor nisi fringilla. |  image1.jpg |
      | Title 1 |                       |            |            | One or more fields are missing        | Aenean mattis tellus ac urna suscipit quis tempor nisi fringilla. | image1.jpg |


    Scenario: Save a challenge draft
      When I visit the "challenge.new" page
      And I fill in title with "Title 1" and description with "description" and fill in start_date with "03-08-2013" and end_date with "09-09-2013" and lead with "Aenean mattis tellus ac urna suscipit quis tempor nisi fringilla." and commitment with "6" and image with "image1.jpg"
      And I press "Save"
      Then I should see a message with "Challenge successfully saved"

    Scenario: Resubmit a declined challenge (submit count should increase)
      Given the following challenge records
        | id | title  | description       | start_date | end_date   | state    | count | supervisor_id |
        | 1  | Title1 | Awesome challenge | 03-08-2013 | 09-09-2013 | draft    | 2     | 1             |
      When I edit the challenge with id "1" and a new description "Nice challenge"
      And I press "Resubmit for Review"
      Then I should see "Title1" in the list

    Scenario: Resubmit a declined challenge with fields filled incorrectly
      Given the following challenge records
        | id | title   | description       | start_date | end_date   | state    | count | supervisor_id |
        | 1  | Title1  | Awesome challenge | 03-08-2013 | 09-09-2013 | draft    | 2     | 1             |
      When I edit the challenge with id "1" and a new description ""
      And I press "Resubmit for Review"
      Then I should see a message with "One or more fields are missing"

    Scenario: Edit a pending for review challenge
      Given the following challenge records
        | id | title   | description       | start_date | end_date   | state   | count | supervisor_id |
        | 1  | Title1  | Awesome challenge | 03-08-2013 | 09-09-2013 | pending | 1     | 1             |
      When I visit the edit challenge "1" page
      Then I should see the "challenges.1" page

    Scenario: Edit an approved challenge
      Given the following challenge records
        | id | title   | description       | start_date | end_date   | state    | count | supervisor_id |
        | 1  | Title1  | Awesome challenge | 03-08-2013 | 09-09-2013 | approved | 1     | 1             |
      When I visit the edit challenge "1" page
      Then I should see the "challenges.1" page

    Scenario: Supervisor can not delete a challenge only revoke a challenge

