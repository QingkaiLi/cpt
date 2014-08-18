Feature: Create content packs
  As a Reading Assistant content administrator
  I should be able to create content packs

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: Click New Content Pack Button
    Given I am logged in with "cas"
    When I go to the Content Pack Index page
    And I click the "New Content Pack" button
    Then I should see a pop up dialog named "New Content Pack"
    Then I should see the <required> <input> with <label>, <name> and <placeholder> within the "New Content Pack" dialog
      | required | input    | label       | name                      | placeholder  |
      | true     | input    | Name        | content_pack[name]        | content name |
      | false    | textarea | Description | content_pack[description] | description  |
    Then I should see the <required> select with <label>, <name> and <options> within the dialog
      | required | label | name                          | options                               |
      | true     | Type  | content_pack[content_type_id] | Reading Assistance,Fluency Assessment |
    Then I should see the <buttons> within the "New Content Pack" dialog
      | buttons |
      | Save    |
      | Cancel  |


  @javascript
  Scenario Outline: Create a new content pack with valid values
    Given I open the New Content Pack dialog
    When I type "<name>" as "Name"
    And I select "<type>" as "Type"
    And I type "<description>" as "description"
    And I click the "Save" button
    And I wait for 3 seconds
    Then I should see the "<name>" content pack created:
      | name   | description  | type   | status      | created_by    |
      | <name> | <description>| <type> | In Progress | Test Engineer |

    Examples:
      | name                | type               | description       |
      | content_pack_lihua1 | Reading Assistance | what's a hot day! |
      | content_pack_lihua2 | Fluency Assessment | what's a hot day! |
      | content_pack_lihua3 | Reading Assistance | what's a hot day! |

  @javascript
  Scenario: Create a new content pack with no content pack name
    Given I open the New Content Pack dialog
    When I click the "Save" button
    Then I should see the message "Required field name missing."
    And the "Name" label turns "Red"

  @javascript
  Scenario Outline: Content pack name should be unique
    Given the following content packs exist
      | name               |
      | content pack one   |
      | content pack two   |
      | content pack three |
    And I open the New Content Pack dialog
    When I type "<name>" as "Name"
    And I click the "Save" button
    Then I should see the message "This contentpack cannot be created because it contains 1 error: The content pack name is already in use. please enter a different value."
    And the "Name" label turns "Red"
    Examples:
      | name               |
      | content pack one   |
      | content pack two   |
      | content pack three |


  @javascript
  Scenario Outline: Content pack name should be less than 256 chars and description should be less than 1024
    Given I open the New Content Pack dialog
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
  Scenario: Clicking Cancel button in "New Content Pack" window will not save the content pack
    Given I open the New Content Pack dialog
    When I type "Test Content Pack" as "Name"
    And I select "Reading Assistance" as "Type"
    And I type "Nothing is important" as "description"
    When I click the "Cancel" button
    Then I should see the "new_content_packs_dialog" disappeared
    And I should see the message "Content Pack List is empty. Create new content packs." in the "content_packs_table"

  @javascript
  Scenario Outline: Create a new content pack with special characters in content pack name and description
    Given I open the New Content Pack dialog
    When I type "<name>" as "Name"
    And I select "<type>" as "Type"
    And I type "<description>" as "description"
    And I click the "Save" button
    And I wait for 5 seconds
    Then I should see the "<name>" content pack created:
      | name   | description  | type   | status      | created_by    |
      | <name> | <description>| <type> | In Progress | Test Engineer |

    Examples:
      | name                                        | type               | description                  |
      | <div>I'm div name</div>                     | Reading Assistance | <div>I'm a description</div> |
      | "I'm double quote"                          | Fluency Assessment | "I'm a description"          |
      | <script>document.body.innerHTML=""</script> | Fluency Assessment | "I'm a description"          |


