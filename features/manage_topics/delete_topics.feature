
Feature: Delete topics
  As a Reading Assistant content administrator
  I should be able to delete empty topics

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: Delete an empty topic
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |       
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |       
    And the following topics exist 
      | name        | content_pack_id | grade_level | created_at |
      | topic one   | 1               | 1.0         | 2013-08-08 |
      | topic two   | 2               | 2.0         | 2013-08-08 |   
      | topic three | 1               | 3.9         | 2013-08-09 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    When I click the content pack "content pack one"
    Then I should see the "Delete" icon for "topic"
    When I click the "Delete" icon for "topic" with name "topic one"
    Then I should see a pop up dialog named "Delete Topic"
    Then I should see the message "Are you sure you want to delete the topic one topic?"
    When I click the "Yes" button
    Then I wait for 5 seconds
    Then I should see the following 1 topics:                    
      | Title           | Grade Level |
      | topic three (0) | 3.9         |  

  @javascript
  Scenario: Delete a not empty topic
    Given the following content packs exist 
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |      
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |      
    And the following topics exist
      | id  | name        | content_pack_id | grade_level | created_at |
      | 100 | topic one   | 1               | 1.9         | 2013-08-07 |  
      | 101 | topic two   | 2               | 2.0         | 2013-08-08 |  
      | 102 | topic three | 1               | 3.9         | 2013-08-09 |  
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 101      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 102      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    When I click the content pack "content pack one"
    Then I should see the "Delete" icon for "topic"
    When I click the "Delete" icon for "topic" with name "topic one"
    Then I should see the notice text "The topic topic one cannot be deleted as it is not empty. Selections within the topic must be deleted or moved first."
    Then I wait for 5 seconds
    Then I should see the following 2 topics:
      | Title           | Grade Level |
      | topic three (1) | 3.9         |
      | topic one (1)   | 1.9         | 

