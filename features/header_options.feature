Feature: Create a basic rest client that can get, put, post, and delete

@extended @get @header
@header.S1
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
@header.S2
Scenario: client uses an Accept and a Content-Type header for a POST
  Given I have a web service
  And I have "POST" service for "/test" with the following headers
    | Content-Type    | application/json                        |
    | Accept          | application/json                        |
    | Accept-Encoding | gzip;q=1.0,deflate;q=0.6,identity;q=0.3 |
    | User-Agent      | Ruby                                    |
  And I am a rest client
  When I have the following header 
    | Content-Type | application/json |
    | Accept | application/json |
  And I "POST" to the web service with the following
  """
    {"Question": "What is the meaning of life?"}
  """
  Then I receive the expected message

@extended @post @authentication
@header.S3
Scenario: client uses basic authentication
  Given I have a web service
  And I have "GET" service for "/test" for user "test" and password "rest"
  And I am a rest client
  And I have basic auth for user "test" and password "rest"
  And I "GET" from the web service
  Then I receive the expected message

@extended @post @authentication
@header.S4
Scenario: client uses a secure web server
  Given I have a secure web service
  And I have "GET" service for "/test" for user "test" and password "rest"
  And I am a rest client
  And I have basic auth for user "test" and password "rest"
  And I "GET" from the web service
  Then I receive the expected message
