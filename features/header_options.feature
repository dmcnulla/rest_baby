Feature: Create a basic rest client that can get, put, post, and delete

@extended @get @headers
Scenario: client rest Get
  Given I have a web service
  And I have "GET" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  And I am a rest client
  When I have the following header 
  | Content-Type | application/json |
  And I "GET" from the web service
  Then the response prints like the following
  """
CODE = 200
MESSAGE = 
BODY = [Empty]
  """
