Feature: Create a basic rest client that can get, put, post, and delete

@extended @get
Scenario: client rest Get
  Given I have a mocked web service
  And I have "GET" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  When I "GET" from "/test"
  Then the response prints like the following
  """
CODE = 200
MESSAGE = 
BODY = [Empty]
  """
