Feature: Edit content packs
  As a Reading Assistant content administrator
  I should be able to edit content packs

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: Edit Content Pack Settings form for an empty content pack
    Given a user exists with name: "Test Engineer"
    Given the following content packs exist
         | id  | name               | content_type_id | description                | status_id |
         |  1  | content pack one   | 1               | This is content pack one   | 1         |
         |  2  | content pack two   | 2               | This is content pack two   | 1         |
         |  3  | content pack three | 1               | This is content pack three | 1         |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I wait for 5 seconds
    Then I should see the "Edit" icon for "content pack"
    When I click the "Edit" icon for "content pack" with name "content pack one"
    Then I should see a pop up dialog named "Edit Content Pack Settings"
    Then I should see the <required> <input> with <label>, <name> and <placeholder> within the "Edit Content Pack Settings" dialog
         | required | input    | label       | name                      | placeholder  |
         | true     | input    | Name        | content_pack[name]        | content name |
         | false    | textarea | Description | content_pack[description] | description  |
    And I should see the <buttons> within the "Edit Content Pack Settings" dialog
         |buttons |
         |Save    |
         |Cancel  |


  @javascript
  Scenario: Check the values for exist content packs
    Given the following content packs exist
         | id  | name               | content_type_id | description                | status_id |
         |  1  | content pack one   | 1               | This is content pack one   | 1         |
         |  2  | content pack two   | 2               | This is content pack two   | 1         |
         |  3  | content pack three | 1               | This is content pack three | 1         |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I wait for 5 seconds
    Then I check the edit items for following empty content packs
         | Name               | Type                   | Description                |
         | content pack one   | Reading Assistance     | This is content pack one   |
         | content pack two   | Fluency Assessment     | This is content pack two   |
         | content pack three | Reading Assistance     | This is content pack three |

  @javascript
   Scenario Outline: Content pack name should be unique while editing
   Given the following content packs exist
         | name               |
         | content pack one   |
         | content pack two   |
         | content pack three |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I wait for 5 seconds
    When I click the "Edit" icon for "content pack" with name "<name>"
    And I type "<change_name_to>" as "Name"
    And I click the "Save" button
    Then I should see the message "This contentpack cannot be modified because it contains 1 error: The content pack name is already in use. please enter a different value."
    And the "Name" label turns "Red"
    Examples:
        | name               |  change_name_to     |
        | content pack one   |  content pack two   |
        | content pack two   |  content pack three |
        | content pack three |  content pack one   |


  @javascript
   Scenario Outline: Content pack name should be less than 256 chars and description should be less than 1024
   Given the following content packs exist
        | id  | name               | content_type_id | description                | status_id |
        |  1  | content pack one   | 1               | This is content pack one   |  1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I wait for 5 seconds
    When I click the "Edit" icon for "content pack" with name "content pack one"
    When I type <type_name_length> chars as "Name"
    And I type <type_desc_length> chars as "description"
    And I click the "Save" button
    And I wait for 3 seconds
    Then the content pack "name" length should be "<correct_name_length>"
    Then the content pack "description" length should be "<correct_desc_length>"
    Examples:
         | type_name_length | correct_name_length | type_desc_length | correct_desc_length |
         | 1                | 1                   | 1                | 1                   |
         | 100              | 100                 | 100              | 100                 |
         | 250              | 250                 | 1000             | 1000                |
         | 256              | 256                 | 1024             | 1024                |
         | 257              | 256                 | 1025             | 1024                |
         | 1000             | 256                 | 2000             | 1024                |


  @javascript
  Scenario: Edit content pack but click cancel button, the value should not be changed
    Given the following content packs exist
      | id  | name               | content_type_id | description                |updated_at | status_id |
      |  1  | content pack one   | 1               | This is content pack one   |2013-08-07 | 1         |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I wait for 5 seconds
    When I click the "Edit" icon for "content pack" with name "content pack one"
    And I type "changing name" as "Name"
    And I type "changing desc" as "description"
    And I click the "Cancel" button
    Then The "Last Edited Date" for "content pack" with name "content pack one" should not be updated
    And the following content packs should exists
      | id  | name               | content_type_id | description                | status_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         |



  @javascript
  Scenario Outline: Edit content pack successfully
    Given the following content packs exist
         | id  | name               | content_type_id | description                | status_id |
         |  1  | content pack one   | 1               | This is content pack one   | 1         |
         |  2  | content pack two   | 2               | This is content pack two   | 1         |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I wait for 5 seconds
    When I click the "Edit" icon for "content pack" with name "<name>"
    And I type "<change_name_to>" as "Name"
    And I type "<change_desc_to>" as "description"
    And I click the "Save" button
    And I wait for 5 seconds
    Then The "Last Edited Date" for "content pack" with name "<change_name_to>" should be updated
    But The "Created By" for "content pack" with name "<change_name_to>" should not be updated
    And the following content packs should exists
        | id  | name               | content_type_id | description         | status_id |
        |  1  | changing name one  | 1               | changing desc one   |  1        |
    Examples:
        | name               |  change_name_to      | change_desc_to      |
        | content pack one   |  changing name one   | changing desc one   |

  @javascript
  Scenario: When clicking cancel button on new/edit content dialog, the dialog will gone
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 |
    And the following topics exist
      | id  | name    | grade_level | content_pack_id | created_at          | updated_at          |
      | 100 | animals | 1.0         | 1               | 2013-08-13 01:55:31 | 2013-08-13 01:55:31 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 100      |
    And I open the New Content Pack dialog
    When I click the "Cancel" button
    Then I should see the "new_content_packs_dialog" disappeared
    And I wait for 3 seconds
    When I click the "Edit" icon for "content pack" with name "content pack one"
    And I click the "Save" button
    And I wait for 3 seconds
    Then The "Last Edited Date" for "content pack" with name "content pack one" should not be updated
    When I click the "Edit" icon for "content pack" with name "content pack two"
    And I click the "Cancel" button
    Then I should see the "edit_content_packs_dialog" disappeared
