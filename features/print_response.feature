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


@put @extended 
Scenario: client rest Put
  Given I have a mocked web service
  And I have "PUT" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  When I "PUT" to "/test" with the following
    """
    {'Answer': 'What did you expect?'}
    """
  Then the response prints like the following
  """
CODE = 200
MESSAGE = 
BODY = [Empty]
  """

@post @extended 
Scenario: client rest Post
  Given I have a mocked web service
  And I have "POST" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  When I "POST" to "/test" with the following
    """
    {'Answer': 'What did you expect?'}
    """
  Then the response prints like the following
  """
CODE = 200
MESSAGE = 
BODY = [Empty]
  """

@delete @extended 
Scenario: client rest Delete
  Given I have a mocked web service
  And I have "DELETE" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  When I "DELETE" from "/test"
  Then the response prints like the following
  """
CODE = 200
MESSAGE = 
BODY = [Empty]
  """
