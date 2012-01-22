Feature: Sign up for an account
  In order to migrate my website to a new domain
  As a user
  I want to maintain my SEO

@javascript
Scenario: The home page
  Given I am a new user
  When I am on the home page
  Then I should see 'three-zero-one'
  And I should see 'Sign In'
  And I should see 'Permanent Redirect'
  And I should see 'Get started now »'
  And I should see 'Occassionally you'll want to move a website to a different domain and/or a different platform. Maybe you're defecting from Wordpress to Jekyll. threezeroone will help you setup permanent redirects for each of your pages to it's new home.'
  
@javascript
Scenario: Creating an account
  Given I am a new user
  When I am on the home page
  And I click on the 'Get started now »' link
  Then I should be on the new user registrations page
  When I enter 'test@example.com' into the 'Email' field
  And I enter 'password' into the 'Password' field
  And I enter 'password' into the 'Password confirmation' field
  And I click the 'Sign up' button
  Then I should be on the manage domains page
  
  
