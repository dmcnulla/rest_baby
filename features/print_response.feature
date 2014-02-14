Feature: Create a basic rest client that can get, put, post, and delete

@extended @get @print
Scenario: client rest Get
  Given I have a web service
  And I have "GET" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  And I am a rest client
# And I pause
  When I "GET" from the web service
  Then I receive the expected message

@put @extended @print
Scenario: client rest Put
  Given I have a web service
  And I have "PUT" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  And I am a rest client
  When I "PUT" to the web service with the following
    """
    {'Answer': 'What did you expect?'}
    """
  Then I receive the expected message

@post @extended @print
Scenario: client rest Post
  Given I have a web service
  And I have "POST" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  And I am a rest client
  When I "POST" to the web service with the following
    """
    {'Answer': 'What did you expect?'}
    """
  Then I receive the expected message

@delete @extended @print
Scenario: client rest Delete
  Given I have a web service
  And I have "DELETE" service for "/test" as follows
    """
    {'Answer': 'What did you expect?'}
    """
  And I am a rest client
  When I "DELETE" from the web service
  Then I receive the expected message
