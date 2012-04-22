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
Scenario: Create a new domain with valid details
  Given I am an existing user
  And I am logged in
  When I go to the manage domains page
  And I click on the 'Add a domain' link
  Then I should be on the new domain page
  When I enter 'domain1.test' into the 'Name' field
  And I enter 'http://www.blekko.com' into the 'Catch all' field
  And I click the 'Create Domain' button
  Then I should be on the manage domains page
  And I should see 'domain1.test'
  And I should see 'http://www.blekko.com'
  And I should see 'Domain added successfully'
  
@javascript
Scenario: Create a new domain with valid details and www on the domain
  Given I am an existing user
  And I am logged in
  When I go to the manage domains page
  And I click on the 'Add a domain' link
  Then I should be on the new domain page
  When I enter 'www.domain1.test' into the 'Name' field
  And I enter 'http://www.blekko.com' into the 'Catch all' field
  And I click the 'Create Domain' button
  Then I should be on the manage domains page
  And I should not see "www.domain1.test"
  And I should see 'domain1.test'
  And I should see 'http://www.blekko.com'
  And I should see 'Domain added successfully'


@javascript
Scenario: Create a new domain with missing details
  Given I am an existing user
  And I am logged in
  When I go to the manage domains page
  And I click on the 'Add a domain' link
  Then I should be on the new domain page
  When I enter '' into the 'Name' field
  And I enter '' into the 'Catch all' field
  And I click the 'Create Domain' button
  Then I should see 'Please enter the source domain.'
  And I should see 'Please enter the default redirect target here.'

@javascript
Scenario: Create a new domain with incorrectly formatted details
  Given I am an existing user
  And I am logged in
  When I go to the manage domains page
  And I click on the 'Add a domain' link
  Then I should be on the new domain page
  When I enter 'http://blekko.com' into the 'Name' field
  And I enter 'www.blekko.com' into the 'Catch all' field
  And I click the 'Create Domain' button
  Then I should see 'Your source domain shouldn't have 'http://' or 'https://' at the start of the url.'
  And I should see 'Please put either 'http://' or 'https://' at the start of the url.'

