Feature: Manage domains
  In order to migrate my website to a new domain
  As a user
  I want to maintain my SEO

@javascript
Scenario: Create a new domain
  Given I am an existing user
  And I am logged in
  And I am on the manage domains page
  When I click on the 'New Domain' link
  Then I should be on the new domain page
  When I enter 'domain1.test' into the 'Name' field
  And I enter 'http://www.youtube.com' into the 'Catch all' field
  And I click the 'Create Domain' button
  Then I should be on the manage domains page
  And I should see 'domain1.test'
  And I should see 'http://www.youtube.com'
  And I should see 'Domain added successfully'
