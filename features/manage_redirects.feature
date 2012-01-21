Feature: Manage redirects
  In order to migrate my website to a new domain
  As a user
  I want to maintain my SEO

@javascript
Scenario:
  Given I am an existing user
  And I have have setup a domain named 'domain1.test' with a catch all of 'http://www.youtube.com/'
  And I am logged in
  When I go to 'http://domain1.test/'
  Then I should be on 'http://www.youtube.com/'
  
