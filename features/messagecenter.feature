Feature: Message Center Incoming Messages
	In order to see messages
	I want to be able to view incoming messages and go to my inbox
    
    Background:
    Given the following user records
	| id | email                          | password | password_confirmation | role |
    | 1  | supervisor@student.utwente.nl  | abcd1234 | abcd1234              | 1    |
    | 2  | participant@student.utwente.nl | abcd1234 | abcd1234              | 0    |
	And the following message records
     | subject             | body                             | sender | receiver | is_read |
	 | Room Change         | Tomorrow we will meet outside!   | 1      | 2        | 0       |
	 | Certificate Awarded | You have received a certificate. | 1      | 2        | 1       |
    When I visit the "login" page
   	And I fill in email with "participant@student.utwente.nl" and password with "abcd1234"
    
    Scenario: View the inbox icon while having unread messages
    When I visit the "dashboard" page
    Then I should see an "active" mailbox icon

    Scenario: View the inbox icon while having no unread messages
    Given I have read all my messages
    When I visit the "dashboard" page
    Then I should see an "inactive" mailbox icon

    Scenario: View the modal inbox overlay
    When I visit the "dashboard" page
    And I click on the "mailbox" button
    Then I should see a modal overlay
    And I should see a title "Messages"
    And I should see a message with "Room Change"

    Scenario: View the inbox page
    When I visit the "dashboard" page
    And I click on the "mailbox" button
    And I click on the "go to inbox" button
    Then I should see the "message.index" page
    And I should see a title "Inbox"