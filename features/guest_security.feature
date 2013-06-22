Feature: Guest Security
  		 In order to keep the site secure
  		 guests need to have very limited permissions
  
  Scenario: go to the login page
    When I visit the "login" page
    Then I should not see a message with "You need to sign in"
    
  Scenario: go to a page you need to be logged in for
    When I visit the "dashboard" page
    Then I should see a message with "You need to sign in"