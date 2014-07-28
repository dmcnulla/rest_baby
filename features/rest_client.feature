Feature: Create a basic rest client that can get, put, post, and delete

@core @get
@rest.S1
Scenario: client rest GET
  Given I have a web service
  And I have "GET" service for "/test"
  And I am a rest client
  When I "GET" from the web service
  Then I receive the expected message

@core @put
@rest.S2
Scenario: client rest PUT
  Given I have a web service
  And I have "PUT" service for "/test"
  And I am a rest client
  When I "PUT" to the web service with the following
    """
    {'Question': 'What is the meaning of life?'}
    """
  Then I receive the expected message

@core @post
@rest.S3
Scenario: client rest POST
  Given I have a web service
  And I have "POST" service for "/test"
  And I am a rest client
  When I "POST" to the web service with the following
    """
    {'Question': 'What is the meaning of life?'}
    """
  Then I receive the expected message

@core @delete
@rest.S4
Scenario: client rest DELETE
  Given I have a web service
  And I have "DELETE" service for "/test"
  And I am a rest client
  When I "DELETE" from the web service
  Then I receive the expected message
