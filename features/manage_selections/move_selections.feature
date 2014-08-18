Feature: move selections
  As a content production contributor,I am able to move any selection into any other content pack

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    And a user exists with name: "Test Engineer"

  @javascript
  Scenario: Move one selection which does not belong to any topic into another content pack
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
      |  3  | content pack three | 2               | This is content pack three | 1         | 2013-08-05 | 1       |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    Then I should see the "CopyMove" icon for "selection"
    When I click the "CopyMove" icon for "selection" with name "selectionAAA"
    Then I should see a pop up dialog named "Move/Copy Selection"
    And I should see the message "Selection: selectionAAA"
    And I should see the message "Current Content Pack: content pack one"
    And I should see the "Content Packs" dropdown list with options "content pack two, content pack three"
    And I should see the "Move" button
    And I should see the "Copy" button
    And I should see the "Cancel" button
    When I click the "Move" button
    And I wait for 3 seconds
    Then I should see the following 2 selections:
      | Title        | Status      | Last Edited By |
      | selectionCCC | In Progress | Test Engineer  |
      | selectionBBB | In Progress | Test Engineer  |

    When I click the "< BACK TO CONTENT PACKS" link
    And I click the content pack "content pack two"
    And I wait for 3 seconds
    Then I should see the following 1 selection:
      | Title        | Status      | Last Edited By |
      | selectionAAA | In Progress | Test Engineer  |

  @javascript
  Scenario: Move one selection within topic into another content pack
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
      |  3  | content pack three | 3               | This is content pack three | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | id  | name        | content_pack_id | grade_level | created_at |
      | 100 | topic one   | 1               | 1.9         | 2013-08-07 |
      | 101 | topic two   | 2               | 2.0         | 2013-08-08 |
      | 102 | topic three | 1               | 3.9         | 2013-08-09 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 101      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 100      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 5 seconds
    Then I should see the following 2 selections listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionCCC | In Progress | 08/08/2013       | Test Engineer  |
      | selectionAAA | In Progress | 08/06/2013       | Test Engineer  |
    And I should see the "CopyMove" icon for "selection"
    When I click the "CopyMove" icon for "selection" with name "selectionAAA"
    Then I should see a pop up dialog named "Move/Copy Selection"
    And I should see the message "Selection: selectionAAA"
    And I should see the message "Current Content Pack: content pack one"
    And I should see the "Content Packs" dropdown list with options "content pack two, content pack three"
    And I should see the "Move" button
    And I should see the "Copy" button
    And I should see the "Cancel" button
    When I select "content pack three" as "Content Packs"
    And I click the "Move" button
    And I wait for 5 seconds
    Then I should see the following 1 selection listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionCCC | In Progress | 08/08/2013       | Test Engineer  |
    Then I should not see the following 1 selection listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionAAA | In Progress | 08/06/2013       | Test Engineer  |
    When I click the "< BACK TO CONTENT PACKS" link
    And I click the content pack "content pack three"
    And I wait for 3 seconds
    Then I should see the following 1 selection:
      | Title        | Status      | Last Edited By|
      | selectionAAA | In Progress | Test Engineer  |

