@nil
Feature: Create a basic rest client that can get, put, post, and delete

@core @put @nil
@nil.S1
Scenario: client rest PUT
  Given I have a web service
  And I have "PUT" service for "/nil" that requires no body
  And I am a rest client
  When I "PUT" to the web service with no body
  Then I receive the no message

@core @post @nil
@nil.S2
Scenario: client rest POST
  Given I have a web service
  And I have "POST" service for "/nil" that requires no body
  And I am a rest client
  When I "POST" to the web service with no body
  Then I receive the no message
