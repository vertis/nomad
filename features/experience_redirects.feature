Feature: Experience redirects
  In order to find what I'm looking for
  As a consumer
  I want to be redirected to the new location of the content

# Need to link doc/fake to pow before these tests
@javascript
Scenario: I want to be redirected to an address even if there is no explicit mapping
  Given I am an existing user
  And I have setup a domain named 'domain1.test' with a catch all of 'http://fake.dev/'
  When I go to 'http://domain1.test/'
  Then I should be on 'http://fake.dev/'
  
@javascript
Scenario: I want to be redirected to an address for the 'www.' of my domain
  Given I am an existing user
  And I have setup a domain named 'domain1.test' with a catch all of 'http://fake.dev/'
  When I go to 'http://www.domain1.test/'
  Then I should be on 'http://fake.dev/'

  
@javascript
Scenario: I want to be redirected to the specific page I'm looking for
  Given I am an existing user
  And I have setup a domain named 'domain1.test' with a catch all of 'http://fake.dev/'
  And I have setup a mapping for the domain named 'domain1.test' with a source of '/data' and a target of 'http://fake.dev/data.html'
  When I go to 'http://domain1.test/data'
  Then I should be on 'http://fake.dev/data.html'

  
