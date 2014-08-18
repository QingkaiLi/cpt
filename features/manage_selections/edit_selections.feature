Feature: Edit selections

  As a content production contributor,
  I want to edit a selection in the content pack
  Background:
    Given a user exists with name: "Test Engineer"
    And the authentication provider "cas" of uid "123" has user with name: "SciLearn"

  @javascript
  Scenario: Click Edit button for some selection
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id |title       |status_id|created_at|updated_at|updater_id |topic_id|
      | 1  |selectionAAA| 1       |2013-08-06|2013-08-06| 1         | 1      |
      | 2  |selectionBBB| 1       |2013-08-07|2013-08-07| 1         | 1      |
      | 3  |selectionCCC| 1       |2013-08-08|2013-08-08| 1         | 1      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    When I click the content pack "content pack one"
    Then I should see the "Edit" icon for "selection"
    When I click the "Edit" icon for "selection" with name "selectionAAA"
    Then I should see a pop up dialog named "Edit Selection Settings"
    And I should see the <required> <input> with <label>, <name> and <placeholder> within the "Edit Selection Settings" dialog
      | required | input    | label                       | name                   | placeholder     |
      | true     | input    | Title                       | selection[title]       | selection title |
      | false    | input    | WCPM Target                 | selection[wcpm_target] | WCPM            |
      | false    | textarea | Description                 | selection[description] | description     |
      | false    | input    | Author                      | selection[author]      | author          |
      | false    | input    | Illustrator                 | selection[illustrator] | illustrator     |
      | false    | input    | Publisher                   | selection[publisher]   | publisher       |
      | false    | textarea | Introductory Text and Audio | selection[intro_text]  | introductory text  |
      | false    | input    | Yes                         | selection[internationally]||
      | false    | input    | No                          | selection[internationally]||
    And I should see the <required> select with <label>, <name> and <options> within the dialog
      | required | label                   | name                              | options |
      | true     | Grade Equivalent Level  | selection[grade_equivalent_level] |None Selected,NP,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4,5,6,7,8,9,10,11,12 |
      | false    | Lexile Level            | selection[lexile_level]           |None Selected,NP,200~249L,250~299L,300~349L,350~399L,400~449L,450~499L,500~549L,550~599L,600~649L,650~699L,700~749L,750~799L,800~849L,850~899L,900~949L,950~999L,1000~1049L,1050~1099L,1100~1149L,1150~1199L,1200~1249L,1250~1299L,1300L |
      | false    | Guided Reading Level    | selection[guided_reading_level]   |None Selected,NP,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z |
    And I should see the <buttons> within the "Edit Selection Settings" dialog
      | buttons      |
      | Save         |
      | Cancel       |

  @javascript
  Scenario: Edit selection and modify data successfully
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id | title      | grade_equivalent_level | lexile_level | guided_reading_level | wcpm_target |internationally | description | author   | illustrator | publisher | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  |selectionAAA|      12                |     NP       |   D                  |   250       |  1             |  AA;AAAA    | Setven.La| Jafferson   | Ching Lee |    1      |2013-08-06  | 2013-08-06 |   1        |  1       |
      | 2  |selectionBBB|      1.0               |    1300L     |   Z                  |   100       |  1             |  BB"bbb"    |Franke.Bk | Ching Lee   | Hale      |    1      |2013-08-07  |2013-08-07  |   1        |  1       |
      | 3  |selectionCCC|       NP               |    250~299L  |   NP                 |    18       |  0             |  <body>     |App.Mid.F | Apple ABCDE | Lee       |    1      |2013-08-08  |2013-08-08  |   1        |  1       |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 2 seconds
    And I click the "Edit" icon for "selection" with name "selectionAAA"
    And I type "modify_AAA" as "Title"
    And I select "3.9" as "Grade Equivalent Level"
    And I select "200~249L" as "Lexile Level"
    And I select "O" as "Guided Reading Level"
    And I choose "No" as "Available Internationally"
    And I type "500" as "WCPM Target"
    And I type "modify_AA;AAAA" as "Description"
    And I type "Stven.la" as "Author"
    And I type "Jerry" as "Illustrator"
    And I type "ching" as "Publisher"
    And I click the "Save" button
    And I wait for 2 seconds
    Then The "Last Edited Date" for "selection" with name "modify_AAA" should be updated
    And The "Last Edited By" for "selection" with name "modify_AAA" should be updated
    And I check the edit items for following selections
      | Title      | Grade Equivalent Level | Lexile Level | Guided Reading Level | WCPM Target | Available Internationally | Description   | Author   | Illustrator | Publisher |
      |modify_AAA  |      3.9               |  200~249L    |   O                  |   500       |  false                    | modify_AA;AAAA| Stven.la | Jerry       | ching     |
      |selectionBBB|      1.0               |    1300L     |   Z                  |   100       |  true                     |  BB"bbb"      |Franke.Bk | Ching Lee   | Hale      |
      |selectionCCC|      NP                |   250~299L   |   NP                 |    18       |   false                   |  <body>       |App.Mid.F | Apple ABCDE | Lee       |




  @javascript
  Scenario: Edit selection let the title is empty
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I click the "Edit" icon for "selection" with name "selectionAAA"
    And I type "" as "Title"
    And I click the "Save" button
    Then I should see the message "Required field title missing."
    And the "Title" label turns "Red"


  @javascript
  Scenario Outline: Selection title should be unique during editting
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | id  | name        | content_pack_id | grade_level | created_at |
      | 100 | topic one   | 1               | 1.9         | 2013-08-07 |
      | 101 | topic two   | 1               | 2.0         | 2013-08-08 |
      | 102 | topic three | 1               | 3.9         | 2013-08-09 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 100      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 101      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I click the "Edit" icon for "selection" with name "selectionAAA"
    And I type "<title>" as "Title"
    And I click the "Save" button
    Then I should see the message "This selection cannot be modified because it contains 1 error: The selection title is already in use. please enter a different value."
    And the "Title" label turns "Red"
    Examples:
      | title         |
      | selectionCCC  |
      | selectionBBB  |


  @javascript
  Scenario Outline: Selection title should be less than 256 chars
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    When I click the content pack "content pack one"
    And I click the "Edit" icon for "selection" with name "selectionAAA"
    And I type <type_name_length> chars as "Title"
    And I type <type_description_length> chars as "Description"
    And I type "ching" as "Illustrator"
    And I click the "Save" button
    And I wait for 3 seconds
    And I click the "Edit" icon for the just edited selection
    Then the selection "title" length should be "<correct_name_length>"
    And the selection "description" length should be "<correct_description_length>"

    Examples:
      | type_name_length | correct_name_length | type_description_length | correct_description_length |
      | 1                | 1                   |  0                      | 0                          |
      | 100              | 100                 |  100                    | 100                        |
      | 250              | 250                 |  1000                   | 1000                       |
      | 256              | 256                 |  1024                   | 1024                       |
      | 257              | 256                 |  1025                   | 1024                       |
      | 1000             | 256                 |  3000                   | 1024                       |


  @javascript
  Scenario: Clicking Cancel button in "Edit Selection Settings" window will not save the change
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I click the "Edit" icon for "selection" with name "selectionAAA"
    And I click the "Save" button
    And I wait for 3 seconds
    Then The "Last Edited Date" for "selection" with name "selectionAAA" should be updated
    And The "Last Edited By" for "selection" with name "selectionAAA" should be updated
    When I click the "Edit" icon for "selection" with name "selectionCCC"
    And I type "If you are happy" as "Title"
    And I click the "Cancel" button
    And I wait for 3 seconds
    Then I should see the "edit_selection_dialog" disappeared
    And The "Last Edited Date" for "selection" with name "selectionCCC" should not be updated
    And I should see the following 3 selections:
      | Title        |
      | selectionCCC |
      | selectionBBB |
      | selectionAAA |
