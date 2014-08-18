Feature: Add topics
  As a content production contributor,
  I want to add a topic in the content pack.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    And a user exists with name: "Test Engineer"
  @javascript
  Scenario: Check topic page while content pack is empty
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
    Then I should see the message "Content Pack is empty. Create new topics, new selections, or import existing selections."

  @javascript
  Scenario Outline: Create a legal topic
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
     And I click the "New Topic" button
    Then I should see a pop up dialog named "New Topic"
     And I should see the <required> <input> with <label>, <name> and <placeholder> within the "New Topic" dialog
      | required | input    | label       | name               | placeholder  |
      | true     | input    | Name        | topic[name]        | topic name   |
      | true     | input    | Grade Level | topic[grade_level] | grade level  |
    And I should see the "Save" button
    And I should see the "Cancel" button
    When I type "<topic_name>" as "Name"
    And I type "<gradelevel>" as "Grade Level"
    And I click the "Save" button
    And I wait for 2 seconds
    Then I should see the following 1 topic:
      | Title               | Grade Level |
      | Songs and Poems (0) | 1.5         |

    Examples:
      | topic_name      | gradelevel |
      | Songs and Poems | 1.5        |



  @javascript
  Scenario:  Clicking Cancel button in "New Topic" window will not save the topic
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
    And I click the "New Topic" button
    Then I should see a pop up dialog named "New Topic"
    When I type "topic one" as "Name"
    And I type "10.68" as "Grade Level"
    And I click the "Cancel" button
    Then I should see the "new_topic_dialog" disappeared
    And I should see the message "Content Pack is empty. Create new topics, new selections, or import existing selections." in the "topics_list"

  @javascript
  Scenario: Create an illegal topic without "name" and "grade level"
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
    And I click the "New Topic" button
    Then I should see a pop up dialog named "New Topic"
    When I click the "Save" button
    Then I should see the message "This topic cannot be created because it contains 2 errors: Required field name missing. Required field grade level missing."
    And the "Name" label turns "Red"
    And the "Grade Level" label turns "Red"

  @javascript
  Scenario: Create a topic with unique "name"
    Given a user exists with name: "Test Engineer"
    And the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | name     | grade_level   | created_at | content_pack_id |
      | topicAAA | 1.5           | 2013-08-08 | 1               |
    When I login and go to the topic page of content pack "content pack one"
    And I click the "New Topic" button
    Then I should see a pop up dialog named "New Topic"
    When I type "topicAAA" as "Name"
    And I type "3.5" as "Grade Level"
    And I click the "Save" button
    Then I should see the message "This topic cannot be created because it contains 1 error: The topic name is already in use. please enter a different value."
    And the "Name" label turns "Red"


  @javascript
  Scenario Outline: the name should be less than 256 chars, the grade level should be x.x, x less than 100
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
    And I click the "New Topic" button
    Then I should see a pop up dialog named "New Topic"
    When I type <type_name_length> chars as "Name"
    And I type "<type_grade_level>" as "Grade Level"
    And I click the "Save" button
    And I wait for 5 seconds
    Then the topic "Name" length should be "<correct_name_length>"
    And the topic "Grade Level" value should be "<correct_grade_level>"
    Examples:
      | type_name_length | correct_name_length | type_grade_level | correct_grade_level |
      | 1                | 1                   | 1.0              | 1.0                 |
      | 100              | 100                 | 100              | 100                 |
      | 1000             | 256                 | 100.99           | 100.99              |

  @javascript
  Scenario Outline: special chars verifination, and the format for grade level should be x.x, x less than 100
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
    And I click the "New Topic" button
    Then I should see a pop up dialog named "New Topic"
    When I type "<type_name>" as "Name"
    And I type "<type_grade_level>" as "Grade Level"
    And I click the "Save" button
    Then I should see the message "Grade level. format x.x, x is an integer between 1 and 100."
    And the "Grade Level" label turns "Red"
    Then I type "<correct_grade_level>" as "Grade Level"
    And I click the "Save" button
    And I wait for 5 seconds
    Then the topic "Name" value should be "<type_name> (0)"
    And the topic "Grade Level" value should be "<correct_grade_level>"
    Examples:
      | type_name                                   | type_grade_level | correct_grade_level |
      | "This's topic: one"                         | 3.455            | 3.45                |
      | select * from topics;                       | X.X              | 10.01               |
      | <html>topic</html>                          | 100.1000         | 100.10              |
      | <script>document.body.innerHTML=""</script> | 101              | 100                 |
