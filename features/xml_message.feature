Feature: Create a basic rest client that can get, put, post, and delete

@core @POST
@xml.S1
Scenario: client rest POST
  Given I have a web service
  And I have an xml service for "/testxml"
  And I am a rest client
  When I "POST" to the web service with the following xml
    """
    <Questions><Question>What is the meaning of life?</Question></Questions>
    """
  Then I receive the xml message
