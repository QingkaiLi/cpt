Feature: Edit topics
  As a Reading Assistant content administrator
  I should be able to edit topics

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: When clicking edit topic icon, it will pop up a dialog, and it will disappear if I click cancel button
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | id  | name    | grade_level | content_pack_id | created_at          | updated_at          |
      | 100 | animals | 1.0         | 1               | 2013-08-13 01:55:31 | 2013-08-13 01:55:31 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 100      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    And I click the "Edit" icon for "topic" with name "animals"
    Then I should see a pop up dialog named "Edit Topic Settings"
    Then I should see the <required> <input> with <label>, <name> and <placeholder> within the "Edit Topic Settings" dialog
      | required | input  | label       | name               | placeholder  |
      | true     | input  | Name        | topic[name]        | topic name   |
      | true     | input  | Grade Level | topic[grade_level] | grade level  |
    Then I should see the <buttons> within the "Edit Topic Settings" dialog
      | buttons |
      | Save    |
      | Cancel  |
    When I click the "Cancel" button
    Then I should see the "new_topic_dialog" disappeared

  @javascript
  Scenario: Edit a topic and save it with no "name" or "grade level"
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    Given the following topics exist
      | id | name       | grade_level | content_pack_id | created_at          | updated_at          |
      |  3 | animals    |         2.0 |               1 | 2013-08-13 01:55:31 | 2013-08-13 01:55:31 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    And I click the "Edit" icon for "topic" with name "animals"
    Then I should see a pop up dialog named "Edit Topic Settings"
    When I type "" as "Name"
    When I type "" as "Grade Level"
    When I click the "Save" button
    Then I should see the message "This topic cannot be modified because it contains 2 errors: Required field name missing. Required field grade level missing."
    Then the "Name" label turns "Red"
    Then the "Grade Level" label turns "Red"

  @javascript
  Scenario: Edit a topic and rename the topic name with another topic's name
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    Given the following topics exist
      | id | name       | grade_level | content_pack_id | created_at          | updated_at          |
      |  3 | animals    |         2.0 |               1 | 2013-08-13 01:55:31 | 2013-08-13 01:55:31 |
      |  4 | snake      |         1.0 |               1 | 2013-08-14 01:55:31 | 2013-08-15 01:55:31 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    And I click the "Edit" icon for "topic" with name "animals"
    Then I should see a pop up dialog named "Edit Topic Settings"
    When I type "snake" as "Name"
    And I click the "Save" button
    Then I should see the message "This topic cannot be modified because it contains 1 error: The topic name is already in use. please enter a different value."
    And the "Name" label turns "Red"

  @wip
  @javascript
  Scenario Outline: Edit the topic for the name should be less than 256 chars, the grade level should be x.x, x less than 100
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    Given the following topics exist
      | id | name       | grade_level | content_pack_id | created_at          | updated_at          |
      |  3 | animals    |         3.0 |               1 | 2013-08-13 01:55:31 | 2013-08-13 01:55:31 |

    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    And I click the "Edit" icon for "topic" with name "animals"
    Then I should see a pop up dialog named "Edit Topic Settings"
    When I type <type_name_length> chars as "Name"
    And I type "<type_grade_level>" as "Grade Level"
    And I click the "Save" button
    Then the topic "Name" length should be "<correct_name_length>"
    Then the topic "Grade Level" should be "<correct_grade_level>"
    Examples:
      | type_name_length | correct_name_length | type_grade_level | correct_grade_level |
      | 1                | 1                   | 1.0              | 1.0                 |
      | 100              | 100                 | 100              | 100                 |
      | 250              | 250                 | 100.1000         | 100.100             |
      | 256              | 256                 | 3.455            | 3.45                |
      | 257              | 256                 | 1024             | 100                 |
      | 1000             | 256                 | 2000             | 1000                |

