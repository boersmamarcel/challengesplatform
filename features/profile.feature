Feature: User profile
    In order to have a profile
    As user s.lang@student.utwente.nl
    I want to be able to view my profile and edit my first and last name
    
    Background:
    Given the following user records
     | firstname | lastname | email                       | password    | password_confirmation | role |
     | Henk      | Kort     | h.kort@student.utwente.nl | pass123567  | pass123567            | 0    |
     | Sjaak     | Lang     | s.lang@student.utwente.nl | pass123567  | pass123567            | 0    |
    When I visit the "login" page
   	And I fill in email with "s.lang@student.utwente.nl" and password with "pass123567"    
    
    Scenario: View my user profile
    When I visit the profile of "s.lang@student.utwente.nl"
    Then I should see the name "Sjaak Lang" on the profile page
    
    Scenario: View user profile of other user
    When I visit the profile of "h.kort@student.utwente.nl"
    Then I should see the name "Henk Kort" on the profile page
    
    Scenario: Edit my first and last name
    When I visit the "user.edit" page for user "s.lang@student.utwente.nl"
    And I fill in firstname with "Hendrik" and lastname with "van Oranje"
    And I press "Update"
    And I visit the profile of "s.lang@student.utwente.nl"
    Then I should see the name "Hendrik van Oranje" on the profile page