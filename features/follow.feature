Feature: User should be able to follow other users
        In order to follow another user
        As user s.lang@student.utwente.nl
        I want to be able to visit the profile page of other users and start following that user
        
        Background:
        Given the following user records
        | firstname | lastname | email                       | password    | password_confirmation | role |
        | Henk      | Kort     | h.kort@student.utwente.nl | pass123567  | pass123567            | 0    |
        | Sjaak     | Lang     | s.lang@student.utwente.nl | pass123567  | pass123567            | 0    |
        When I visit the "login" page
      	And I fill in email with "s.lang@student.utwente.nl" and password with "pass123567"

        Scenario: See follow button on profile page
        Given "s.lang@student.utwente.nl" is not following "h.kort@student.utwente.nl"
        When I visit the profile of "h.kort@student.utwente.nl"
        Then I should see a link "Follow"
        
        Scenario: Follow an user
        Given "s.lang@student.utwente.nl" is not following "h.kort@student.utwente.nl"
        When I visit the profile of "h.kort@student.utwente.nl"
        And I follow "Follow"
        Then I should see a message with "You are now following this user"
        And I should see "Sjaak Lang" in the followed by list
        
        Scenario: Unfollow an user
        Given "s.lang@student.utwente.nl" is following "h.kort@student.utwente.nl"
        When I visit the profile of "h.kort@student.utwente.nl"
        And I follow "Unfollow"
        Then I should see a message with "You stopped following this user"
        And I should not see "Sjaak Lang" in the followed by list
        
        Scenario: Follow yourself
        When I visit the profile of "s.lang@student.utwente.nl"
        Then I should not see button "Follow"
        
        Scenario: Open followers list and check if the user is in the list
        Given "s.lang@student.utwente.nl" is following "h.kort@student.utwente.nl"
        When I visit the profile of "h.kort@student.utwente.nl"
        And I follow "See all followers"
        Then I should see "Sjaak Lang" in the followed by list
        
        
        Scenario: Open follows list and check if the user is in the list
        Given "s.lang@student.utwente.nl" is following "h.kort@student.utwente.nl"
        When I visit the profile of "s.lang@student.utwente.nl"
        And I follow "See all"
        Then I should see "Henk Kort" in the follows users 
        
