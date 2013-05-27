Feature: Sending Messages using the message center
	In order to announce changes and communicate
	with other users, I want to be able to send
	messages through the message center.
	
	Background:
    Given the following user records
    | firstname | lastname | email                           | password | password_confirmation  | role  |
    | A         | B        | supervisor@student.utwente.nl   | abcd1234 | abcd1234               | 1     |
    | A         | C        | participant@student.utwente.nl  | abcd1234 | abcd1234               | 0     |
    | A         | D        | participant2@student.utwente.nl | abcd1234 | abcd1234               | 0     |
    | A         | E        | participant3@student.utwente.nl | abcd1234 | abcd1234               | 0     |
    And the following challenge records
    | id  | title   | description  | start_date | end_date  | state    | count | supervisor_id |
    | 1   | Title1  | Description1 | next week  | 09-09-2060| approved | 1     | 1             |
    | 2   | Title2  | Description2 | 09-09-2059 | 09-09-2060| pending  | 2     | 1             |
    | 3   | Title3  | Description3 | 09-09-2059 | 09-09-2060| proposal | 1     | 1             |
    | 4   | Title4  | Description4 | 09-09-2059 | 09-09-2060| proposal | 4     | 1             |
    | 5   | Title5  | Description5 | next month | 09-09-2060| approved | 2     | 1             |
    | 6   | Title6  | Description6 | 09-09-2059 | 09-09-2060| approved | 2     | 1             |
    | 7   | Title7  | Description7 | 15-05-2013 | 09-09-2060| approved | 2     | 1             |

    @javascript
    Scenario: Sending a message to challenge participants
       When user "participant@student.utwente.nl" is enrolled in challenge "1"
        And I visit the "login" page
        And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"
        And I send a new message with subject "Hello" and contents "World" for challenge "1"
       Then I should see a message with "Your message has been sent"
        And user "participant@student.utwente.nl" should have unread messages

    @javascript
    Scenario: Sending a message to non-existent challenge participants
       When user "participant@student.utwente.nl" is enrolled in challenge "1"
        And I visit the "login" page
        And I fill in email with "supervisor@student.utwente.nl" and password with "abcd1234"
        And I send a new message with subject "Hello" and contents "World" for challenge "1000"
       Then I should see a message with "You do not have the permissions required to view this page"
        And user "participant@student.utwente.nl" should not have unread messages
        
    @javascript
    Scenario: Sending a message to a user who follows you
      Given "participant2@student.utwente.nl" is following "participant@student.utwente.nl"
       When I visit the "login" page
        And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
        And I visit the "user.2.profile" page
        And I follow "A D"
        And I follow "Send a Message"
        And I fill in "subject" with "Hey!"
        And I fill in "body" with "How are you?"
        And I press "Send"
       Then I should see a message with "Your message has been sent"
       
       @javascript
       Scenario: Sending a message to a user who is enrolled in the same challenge as you
         Given user "participant@student.utwente.nl" is enrolled in challenge "1"
           And user "participant3@student.utwente.nl" is enrolled in challenge "1"
          When I visit the "login" page
           And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
           And I follow "Challenges"
           And I follow "Title1"
           And I follow "A E"
           And I follow "Send a Message"
           And I fill in "subject" with "Hey!"
           And I fill in "body" with "How are you?"
           And I press "Send"
          Then I should see a message with "Your message has been sent"