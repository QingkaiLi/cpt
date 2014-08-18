Feature: Add selections
  As a content production contributor,
  I want to add a selection in the content pack
  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: open new selection window
    Given the following content packs exist
      | name |
      | content pack one |
      | content pack two |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    Then I should see the "New Selection" button
    When I click the "New Selection" button
    Then I should see a pop up dialog named "New Selection"
    And I should see the radio "No" for "Available Internationally" set by defult
    And I should see the <required> <input> with <label>, <name> and <placeholder> within the "New Selection" dialog
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
    And I should see the <buttons> within the "New Selection" dialog
        | buttons      |
        | Save         |
        | Cancel       |

  @javascript
  Scenario Outline: Add a selection
    Given the following content packs exist
      | name |
      | content pack three |
      | content pack four  |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack three"
    Then I should see the "New Selection" button
    When I click the "New Selection" button
    Then I should see a pop up dialog named "New Selection"
    When I type "<title>" as "Title"
    And I select "<grade>" as "Grade Equivalent Level"
    And I select "<lexile>" as "Lexile Level"
    And I select "<guided>" as "Guided Reading Level"
    And I choose "<available internationally>" as "Available Internationally"
    And I type "<wcpm>" as "WCPM Target"
    And I type "<description>" as "Description"
    And I type "<author>" as "Author"
    And I type "<iiustrator>" as "Illustrator"
    And I type "<publisher>" as "Publisher"
    And I type "<introductory>" as "Introductory Text and Audio"
    And I click the "Save" button
    And I wait for 3 seconds
    Then I should see the "<title>" selection created:
      | title   | status      | last_edited_by | errors |
      | <title> | In Progress | Test Engineer  |   -    |

     Examples:
      |title           |grade|lexile  |guided|wcpm| available internationally |description|author|iiustrator|publisher|introductory|
      |If you are happy|1.2  |250~299L|  E   |120 | Yes                       |It for K- 3|mxie  |ching     |val      |Happy       |
      |snake           |1.3  |250~299L|  F   |130 | No                        |It for K- 3|mxie  |ching     |val      |Happy       |

  @javascript
  Scenario: Check "Title" and "Grade Equivalent Level" is the required options
    Given the following content packs exist
      | name               |
      | content pack three |
      | content pack four  |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack three"
    Then I should see the "New Selection" button
    When I click the "New Selection" button
    And I click the "Save" button
    Then I should see the message "This selection cannot be created because it contains 2 errors: Required field title missing. Required field grade equivalent level missing."
    And the "Title" label turns "Red"
    And the "Grade Equivalent Level" label turns "Red"
    When I type "If you're happy" as "Title"
    And I click the "Save" button
    Then I should see the message "This selection cannot be created because it contains 1 error: Required field grade equivalent level missing."
    And the "Grade Equivalent Level" label turns "Red"
    When I click the "Cancel" button
    And I click the "New Selection" button
    And I select "NP" as "Grade Equivalent Level"
    And I click the "Save" button
    Then I should see the message "This selection cannot be created because it contains 1 error: Required field title missing."
    And the "Title" label turns "Red"

  @javascript
  Scenario Outline: Selection title should be unique
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
    Then I should see the "New Selection" button
    When I click the "New Selection" button
    And I type "<title>" as "Title"
    And I select "NP" as "Grade Equivalent Level"
    And I type "Cherry" as "Illustrator"
    And I click the "Save" button
    Then I should see the message "This selection cannot be created because it contains 1 error: The selection title is already in use. please enter a different value."
    And the "Title" label turns "Red"
    Examples:
      | title         |
      | selectionAAA  |
      | selectionBBB  |

  @javascript
  Scenario Outline: the restriction for each field as following:
    Title: less than 256 Char
    Description: less than 1024 char
    Author: less than 256 char
    Illustrator: less than 256 char
    Publisher: less than 256 char
    Introductory text and Introductory Audio: less than 1024
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I click the "New Selection" button
    And I type <type_name_length> chars as "Title"
    And I select "NP" as "Grade Equivalent Level"
    And I type <type_description_length> chars as "Description"
    And I type <type_author> chars as "Author"
    And I type <type_illustrator> chars as "Illustrator"
    And I type <type_publisher> chars as "Publisher"
    And I type <type_introductory> chars as "Introductory Text and Audio"
    And I click the "Save" button
    And I click the "Edit" icon for the just created selection
    And I wait for 3 seconds
    Then the selection "title" length should be "<correct_name_length>"
    And the selection "description" length should be "<correct_description_length>"
    And the selection "author" length should be "<correct_author>"
    And the selection "illustrator" length should be "<correct_illustrator>"
    And the selection "publisher" length should be "<correct_publisher>"
    And the selection "introductory" length should be "<correct_introductory>"

    Examples:
      | type_name_length | correct_name_length | type_description_length | correct_description_length |type_author|correct_author|type_illustrator  |correct_illustrator  |type_publisher |correct_publisher |type_introductory|correct_introductory|
      | 1                | 1                   |  0                      | 0                          | 1         |  1           | 1                |  1                  | 1             |1                 |0                |0                   |
      | 100              | 100                 |  100                    | 100                        | 100       |  100         | 100              |  100                | 100           |100               |100              |100                 |
      | 256              | 256                 |  1024                   | 1024                       | 256       |  256         | 256              |  256                | 256           |256               |1024             |1024                |
      | 257              | 256                 |  1025                   | 1024                       | 257       |  256         | 257              |  256                | 257           |256               |1025             |1024                |
      | 1000             | 256                 |  3000                   | 1024                       | 1024      |  256         | 1024             |  256                | 1024          |256               |3000             |1024                |

  @javascript
  Scenario Outline: Check the restriction for WCPM
    WCPM target: required but OK to save. Integer between 1 and 999.
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I click the "New Selection" button
    And I type "Animal" as "Title"
    And I select "NP" as "Grade Equivalent Level"
    And I type "<wcpm>" as "WCPM Target"
    And I type "Cherry" as "Illustrator"
    And I click the "Save" button
    Then I should see the message "This selection cannot be created because it contains 1 error: Wcpm target is an integer between 1 and 999."
    And the "WCPM Target" label turns "Red"
    When I type "1" as "WCPM Target"
    And I click the "Save" button
    When I wait for 3 seconds
    Then I should see the following 1 selections:
      |Title |
      |Animal|
    When I click the "Edit" icon for the just created selection
    And I type "999" as "WCPM Target"
    And I click the "Save" button
    And I wait for 3 seconds
    Then I should see the following 1 selections:
      |Title |
      |Animal|

    Examples:
      | wcpm  |
      | a     |
      | %     |
      | -1    |
      | 26.5  |
      | 1-3   |

  @javascript
  Scenario: Clicking Cancel button in "New Selection" window will not save the selection
    Given the following content packs exist
      | name      |
      | Animals   |
      | Happy Day |
    And I am logged in with "cas"
    When I click the content pack "Happy Day"
    Then I should see the "New Selection" button
    When I click the "New Selection" button
    Then I should see a pop up dialog named "New Selection"
    When I type "grass green all around" as "Title"
    And I type "ching" as "Illustrator"
    When I click the "Cancel" button
    Then I should see the "new_selection_dialog" disappeared
    And I should see the message "Content Pack is empty. Create new topics, new selections, or import existing selections." in the "topics_list"

  @javascript
  Scenario: Clicking Close button in "New Selection" window will not save the selection
    Given the following content packs exist
      | name      |
      | Animals   |
      | Happy Day |
    And I am logged in with "cas"
    When I click the content pack "Happy Day"
    Then I should see the "New Selection" button
    When I click the "New Selection" button
    Then I should see a pop up dialog named "New Selection"
    When I type "grass green all around" as "Title"
    And I type "ching" as "Illustrator"
    When I click the "×" button
    Then I should see the "new_selection_dialog" disappeared
    And I should see the message "Content Pack is empty. Create new topics, new selections, or import existing selections." in the "topics_list"
