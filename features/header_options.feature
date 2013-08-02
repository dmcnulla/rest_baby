Feature: Create a basic rest client that can get, put, post, and delete

@extended @get @headers
Scenario: client uses an Accept header for a GET
  Given I have a web service
  And I have "GET" service for "/test" with the following headers
    | Accept | application/json |
  And I am a rest client
  When I have the following header 
    | Accept | application/json |
  And I "GET" from the web service
  Then I receive the expected message

@extended @post @headers
Scenario: client uses an Accept and a Content-Type header for a POST
  Given I have a web service
  And I have "POST" service for "/test" with the following headers
    | Content-Type | application/json |
    | Accept       | application/json |
  And I am a rest client
  When I have the following header 
    | Content-Type | application/json |
    | Accept | application/json |
  And I "POST" to the web service with the following
    """
    {'Question': 'What is the meaning of life?'}
    """
  Then I receive the expected message

@extended @post @authentication
Scenario: client uses an Accept and a Content-Type header for a GET
  Given I have a web service
  And I have "GET" service for "/test"
  And I am a rest client
  And I have basic auth for user "test" and password "rest"
  And I "GET" from the web service
  Then I receive the expected message
