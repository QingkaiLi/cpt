Feature: The order of selections and topics can be kept
  As a content production contributor,
  I should be able to reorder the selections and topics in the content pack.
  And the order should be respected.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: reorder selections when there are only selections in the content pack
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
    And I wait for 3 seconds
    Then I should see the following 3 selections:
      | Title        | Status      | Last Edited By |
      | selectionCCC | In Progress | Test Engineer  |
      | selectionBBB | In Progress | Test Engineer  |
      | selectionAAA | In Progress | Test Engineer  |
    When I drag selection "selectionBBB" into the "first" position
    Then I should see the following 3 selections:
      | Title        | Status      | Last Edited By |
      | selectionBBB | In Progress | Test Engineer  |
      | selectionCCC | In Progress | Test Engineer  |
      | selectionAAA | In Progress | Test Engineer  |
    When I am logged out
    And I am logged in with "CAS"
    And I go to the Content Pack Index page
    And I click the content pack "content pack one"
    Then I should see the following 3 selections:
      | Title        | Status      | Last Edited By |
      | selectionBBB | In Progress | Test Engineer  |
      | selectionCCC | In Progress | Test Engineer  |
      | selectionAAA | In Progress | Test Engineer  |
    # When I click the "New Topic" button
    # Then I should see a pop up dialog named "New Topic"
    # When I type "topic one" as "Title"
    # And I type "3.5" as "Grade Level"
    # And I click the "Save" button
    # Then I should see the following 3 selections listed in "topic one":
    #   |Title       |
    #   |selectionBBB|
    #   |selectionCCC|
    #   |selectionAAA|
@wip
  @javascript
  Scenario: Sort selections within topics
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
      |  3  | content pack three | 3               | This is content pack three | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | id  | name        | content_pack_id | grade_level | created_at |
      | 100 | topic one   | 1               | 1.9         | 2013-08-07 |
      | 101 | topic two   | 1               | 2.0         | 2013-08-08 |
      | 102 | topic three | 1               | 3.9         | 2013-08-09 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 101      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 100      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    When I wait for 3 seconds
    Then I should see the following 3 topics:
      |Title           |
      |topic three (0) |
      |topic two (1)   |
      |topic one (2)   |
    When I drag topic "topic two" into the "first" position
    Then I should see the following 3 topics:
      |Title           |
      |topic two (1)   |
      |topic three (0) |
      |topic one (2)   |
    When I drag selection "selectionAAA" into the "first" position under "topic one"
    Then I should see the following 2 selections:
      |Title         |
      |selectionAAA  |
      |selectionCCC  |
    When I am logged out
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    Then I should see the following 3 topics:
      |Title           |
      |topic two (1)   |
      |topic three (0) |
      |topic one (2)   |
    And I should see the following 2 selections listed in "topic one":
      |Title         |
      |selectionAAA  |
      |selectionCCC  |
@wip
  @javascript
  Scenario: Sort selections by dragging into topics
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
      |  3  | content pack three | 3               | This is content pack three | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | id  | name        | content_pack_id | grade_level | created_at |
      | 100 | topic one   | 1               | 1.9         | 2013-08-07 |
      | 101 | topic two   | 1               | 2.0         | 2013-08-08 |
      | 102 | topic three | 1               | 3.9         | 2013-08-09 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 101      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 100      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    When I wait for 3 seconds
    Then I should see the following 3 topics:
      |Title           |
      |topic three (0) |
      |topic two (1)   |
      |topic one (2)   |
    When I click the "New Selection" button
    Then I should see a pop up dialog named "New Selection"
    When I type "selectionDDD" as "Title"
    And I click the "Save" button
    Then I should see the selection "selectionDDD" locate at top
    And I should see the selection "selectionDDD" doesn't under any topics
    When I click the arrow icon of topic "topic two"
    Then I should not see the following 1 selections listed in "topic two":
      |Title       |
      |selectionBBB|
    When I drag selection "selectionDDD" into "topic two"
    Then I should not see the selection "selectionDDD" locate in the top
    And I should see the following 3 topics:
      |Title           |
      |topic one (2)   |
      |topic two (2)   |
      |topic three (0) |
    When I click the arrow icon of topic "topic two"
    Then I should see the following 2 selections listed in "topic two":
      |Title       |
      |selectionDDD|
      |selectionBBB|
@wip
  @javascript
  Scenario: Sort selections by drop out topics
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
      |  3  | content pack three | 3               | This is content pack three | 1         | 2013-08-06 | 1       |
    And the following topics exist
      | id  | name        | content_pack_id | grade_level | created_at |
      | 100 | topic one   | 1               | 1.9         | 2013-08-07 |
      | 101 | topic two   | 1               | 2.0         | 2013-08-08 |
      | 102 | topic three | 1               | 3.9         | 2013-08-09 |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 100      |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 101      |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 100      |
      | 4  | selectionDDD | 1         | 2013-08-08 | 2013-08-08 | 1          | 100      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    Then I should see the following 3 topics:
      |Title            |
      |topic three (0)  |
      |topic two (1)    |
      |topic one (3)    |
    When I drag selection "selectionDDD" out of "topic one"
    Then I should see the selection "selectionDDD" locate at top
    And I should see the selection "selectionDDD" doesn't under any topics
    When I drag selection "selectionAAA" into "topic three"
    Then I should see the following 3 topics:
      |Title           |
      |topic three (1) |
      |topic two (1)   |
      |topic one (1)   |
    And I should see the following 1 selections listed in "topic three":
      |Title       |
      |selectionAAA|
