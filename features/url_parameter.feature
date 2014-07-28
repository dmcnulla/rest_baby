Feature: As a rest client I need to use URL parameters in order to send those parameters to a restful service.

@parameter
@parameter.S1
Scenario: Send parameter to a service.
  Given I have a web service
  And I have "GET" service for "/test?first=1&second=2&third=3"
  And I am a rest client
  When I "GET" from the web service with the parameters
  	| first  | 1 |
  	| second | 2 |
  	| third  | 3 |
  Then I receive a message with "first=1&second=2&third=3"
