Feature: Add challenge
    In order to add challenges
    As an admin or supervisor
    I want to be able to submit a proposal for review and see the current stats of an approved challenge
    
    Scenario Outline: Submit new challenge
        When I visit the "challenge.new" page
        And I fill in title with "<title>" description with "<description>"  and fill in start_date with "<start_date>" and end_date with "<end_date>"
        And I press "Create Challenge"
        Then I should see a message with "<message>"
      
    Examples:
     |  title   | description               | start_date        | end_date          | message                                   |
     | Title 1  | Challenge description     | 03-08-2013        | 09-09-2013        | Challenge is pending for review           |
     | Title 1  | Challenge description     | 09-09-2013        | 03-08-2013        | End date can not be before start date     |
     | Title 1  |                           | 03-08-2013        | 09-09-2013        | One or more fields are missing            |
     | Title 1  |                           |                   |                   | One or more fields are missing            |

    
    Scenario: Save a challenge proposal
        When I visit the "challenge.new" page
        And I fill in title with "Title 1" description with "description"  and fill in start_date with "03-08-2013" and end_date with "09-09-2013"
        And I press "Save"
        Then I should see a message with "Challenge successfully saved"
    
    
    Scenario: Revoke a pending for review challenge
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | pending     | 1     |
        When I visit the "challenges.pending" page
        And I follow "Revoke"
        Then I should see a message with "Challenge successfully revoked"
    
    
    Scenario: Revoke an approved challenge
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | approved    | 1     |
        When I visit the "challenges.approved" page
        And I follow "Revoke"
        Then I should see a message with "Challenge successfully revoked"
    
    @focus
    Scenario: View declined challenges
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | declined    | 1     |
        | 2  | Title2  | Awesome challenge         | 03-08-2013        | 09-09-2013        | declined    | 1     |
        When I visit the "challenges.declined" page
        Then I should see "Title1" in the list
        And I should not see "Title2" in the list
        
    
    Scenario: Resubmit a declined challenge (submit count should increase)
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | declined    | 1     |
        When I edit the challenge with id "1" and a new description "Nice challenge"
        And I press "Submit"
        Then I should see a message with "Challenge successfully resubmitted"
        And I should see a submission count of "2"
        
    
    Scenario: Resubmit a declined challenge with fields filled incorrectly
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | declined    | 1     |
        When I edit the challenge with id "1" and a new description ""
        And I press "Submit"
        Then I should see a message with "One or more fields are missing"
    
    Scenario: View approved challenges
       Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | approved    | 1     |
       When I visit the "challenges.approved" page
       When I open the challenge with id "1"
       Then I should see a title "Title1" and description "Awesome challenge" and start_date "03-08-2013" and end_date "09-09-2013" 
       And I should see a button "Revoke"
        
        
    Scenario: View pending for review challenges
       Given the following challenge records
       | id | title   | description               | start_date   | end_date         | state       | count |
       | 1  | Title1  | Awesome challenge         | 03-08-2013   | 09-09-2013       | pending     | 1     |
       When I visit the "challenges.pending" page
       When I open the challenge with id "1"
       Then I should see a title "Title1" and description "Awesome challenge" and start_date "03-08-2013" and end_date "09-09-2013" 
       And I should see a button "Revoke"
    
    Scenario: View a proposal challenge
      Given the following challenge records
      | id | title   | description               | start_date        | end_date          | state       | count |
      | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | proposal    | 1     |
      When I visit the "challenges.proposal" page
      When I open the challenge with id "1"
      Then I should see a title "Title1" and description "Awesome challenge" and start_date "03-08-2013" and end_date "09-09-2013"
      And I should see a button "Submit"
      And I should see a button "Save"
    
    Scenario: Edit a pending for review challenge
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | pending     | 1     |
        When I visit the edit challenge "1" page
        Then I should see a message with "Can not edit a pending for review challenge"
    
    Scenario: Edit an approved challenge
        Given the following challenge records
        | id | title   | description               | start_date        | end_date          | state       | count |
        | 1  | Title1  | Awesome challenge         | 03-08-2013        | 09-09-2013        | approved    | 1     |
        When I visit the edit challenge "1" page
        Then I should see a message with "Can not edit an approved challenge"
        
        
    Scenario: Not logged in and visit challenges.*
      When I visit the "challenges.index" page
      Then I should be redirected to "session.new" page
      
    Scenario: Supervisor can not delete a challenge only revoke a challenge
    
      

    
    