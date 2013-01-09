Feature: Sign up for an account
  In order to migrate my website to a new domain
  As a user
  I want to maintain my SEO

@javascript
Scenario: The home page
  Given I am a new user
  When I go to the home page
  Then I should see 'Sign In'
  And I should see 'Nomad'
  And I should see 'Get started now »'
  And I should see 'Move a website to a new domain and have the traffic follow.'
  
@javascript
Scenario: Creating an account
  Given I am a new user
  When I go to the home page
  And I click on the 'Get started now »' link
  Then I should be on the new user registrations page
  When I enter 'test@example.com' into the 'Email' field
  And I enter 'password' into the 'Password' field
  And I enter 'password' into the 'Password confirmation' field
  And I click the 'Register' button
  Then I should be on the domains page
  
  
