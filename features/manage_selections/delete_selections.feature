Feature: Delete selections
  As a content production contributor,
  I am able to delete selections in the content pack when I feel the Selections are not so good.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: delete selections which are out of topics
    Given the following content packs exist
      | id | name             | content_type_id | description              | status_id | updated_at | user_id |
      | 1  | content pack one | 1               | This is content pack one | 1         | 2013-08-07 | 1       |
      | 2  | content pack two | 2               | This is content pack two | 1         | 2013-08-06 | 1       |
    Given the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    Then I should see the "Delete" icon for "selection"
    When I click the "Delete" icon for "selection" with name "selectionAAA"
    And I wait for 2 seconds
    Then I should see a pop up dialog named "Delete Selection"
    Then I should see the message "Are you sure you want to delete the selectionAAA selection?"
    And I click the "Yes" button
    And I wait for 3 seconds
    Then I should see the following 2 selections:
      | Title        | Status      | Last Edited By |
      | selectionCCC | In Progress | Test Engineer  |
      | selectionBBB | In Progress | Test Engineer  |

  @javascript
  Scenario: delete selections under topics
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
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 100      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 101      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    When I click the content pack "content pack one"
    Then I should see the "Delete" icon for "selection"
    When I click the "Delete" icon for "selection" with name "selectionAAA"
    Then I should see a pop up dialog named "Delete Selection"
    Then I should see the message "Are you sure you want to delete the selectionAAA selection?"
    And I click the "Yes" button
    And I wait for 3 seconds
    And I should see the following 1 selections listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionBBB | In Progress | 08/07/2013       | Test Engineer  |

