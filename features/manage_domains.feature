Feature: Manage domains
  In order to migrate my website to a new domain
  As a user
  I want to maintain my SEO


@javascript
Scenario: Should be redirected to the manage domains page if logged in
  Given I am an existing user
  And I am logged in
  When I go to the home page
  Then I should be on the manage domains page

@javascript
Scenario: Create a new domain
  Given I am an existing user
  And I am logged in
  When I go to the manage domains page
  And I click on the 'New Domain' link
  Then I should be on the new domain page
  When I enter 'domain1.test' into the 'Name' field
  And I enter 'http://www.blekko.com' into the 'Catch all' field
  And I click the 'Create Domain' button
  Then I should be on the manage domains page
  And I should see 'domain1.test'
  And I should see 'http://www.blekko.com'
  And I should see 'Domain added successfully'
  
@javascript
Scenario: Create a mapping with valid details
  Given I am an existing user
  And I have setup a domain named 'domain1.test' with a catch all of 'http://www.blekko.com/'
  And I am logged in
  When I go to the manage domains page
  When I click on the 'Manage' link
  Then I should be on the manage domain page for 'domain1.test'
  And I should see 'Basic Details'
  And I should see 'domain1.test' in the 'Name' field
  And I should see 'http://www.blekko.com/' in the 'Catch all' field
  And I should see 'Mappings'
  When I click on the 'Mappings' link
  And I click on the 'Add a mapping' link
  And I enter '/example' into the 'Source path' field
  And I enter 'http://www.blekko.com/ws/example' into the 'Target' field
  And I click the 'Create Mapping' button
  Then I should be on the manage domain page for 'domain1.test'
  When I click on the 'Mappings' link
  And I should see '/example'
  And I should see 'http://www.blekko.com/ws/example'

@javascript
Scenario: Edit a mapping with valid details
  Given I am an existing user
  And I have setup a domain named 'domain1.test' with a catch all of 'http://www.blekko.com/'
  And I have setup a mapping for the domain named 'domain1.test' with a source of '/test' and a target of 'http://blekko.com/ws/test'
  And I am logged in
  When I go to the manage domain page for 'domain1.test'
  And I click on the 'Mappings' link
  Then I should see '/test'
  And I should see 'http://blekko.com/ws/test'
  When I click on the 'Edit' link
  Then I should see '/test' in the 'Source path' field
  And I should see 'http://blekko.com/ws/test' in the 'Target' field
  And I enter '/servers' into the 'Source path' field
  And I enter 'http://blekko.com/ws/servers' into the 'Target' field
  And I click the 'Update Mapping' button
  Then I should be on the manage domain page for 'domain1.test'
  When I click on the 'Mappings' link
  And I should see '/servers'
  And I should see 'http://blekko.com/ws/servers'
