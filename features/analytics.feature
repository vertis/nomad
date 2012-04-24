Feature: Analytics
  In order to protect my utilise the service fully
  As a user
  I want see what mappings I'm missing

@javascript
Scenario: View the requests hitting the catch-all
  Given I am an existing user
  And I have setup a domain named 'domain1.test' with a catch all of 'http://www.blekko.com/'
  And I go to 'http://domain1.test/myfakepath'
  And I am logged in
  When I go to the domains page
  When I click on the 'Edit' link
  Then I should be on the domain page for 'domain1.test'
  And I should see 'Analytics'
  When I click on the 'Analytics' link
  And I should see 'Last 30 unmapped requests'
  And I should see '/myfakepath'
  And I should see 'Ignore'
