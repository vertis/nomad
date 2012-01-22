Feature: Manage redirects
  In order to find what I'm looking for
  As a consumer
  I want to be redirected to the new location of the content

@javascript
Scenario:
  Given I am an existing user
  And I have have setup a domain named 'domain1.test' with a catch all of 'http://www.youtube.com/'
  And I am logged in
  When I go to 'http://domain1.test/'
  Then I should be on 'http://www.youtube.com/'
  
