Feature: User should be able to follow other users
        In order to follow another user
        As user student2@student.utwente.nl
        I want to be able to visit the profile page of other users and start following that user
        
        Background:
        Given the following user records
        | email                       | password    | password_confirmation | role |
        | student1@student.utwente.nl | pass123567  | pass123567            | 1    |
        | student2@student.utwente.nl | pass123567  | pass123567            | 1    |
        When I visit the "login" page
      	And I fill in email with "student2@student.utwente.nl" and password with "pass123"

        @focus
        Scenario: See follow button on profile page
        Given "student1@student.utwente.nl" is not following "student2@student.utwente.nl"
        When I visit the profile of "student1@student.utwente.nl"
        Then I should see a button "Follow"
        
        Scenario: Follow an user
        Given "student1@student.utwente.nl" is not following "student2@student.utwente.nl"
        When I visit the profile of "student1@student.utwente.nl"
        And I press "Follow"
        Then I should see a message with "You started following this user"
        
        Scenario: Unfollow an user
        Given "student2@student.utwente.nl" is following "student1@student.utwente.nl"
        When I visit the profile of "student1@student.utwente.nl"
        And I press "Unfollow"
        Then I should see a message with "You stopped following this user"
        
        Scenario: Follow yourself
        When I visit the profile of "student2@student.utwente.nl"
        Then I should not see button "Follow"
        
        
