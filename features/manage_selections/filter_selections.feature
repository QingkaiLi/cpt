Feature: Filter Selections By
  As a content production contributor,
  I want to filter selections by Filter Selections By
  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: No "Filter Selections By" when content pack is empty
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    When I wait for 5 seconds
    Then I should not see "Filter Selections By"

  @javascript
  Scenario: Filter selections without topics
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 2         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 3         | 2013-08-08 | 2013-08-08 | 1          | 1        |
      | 4  | selectionDDD | 3         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    Then I should see "Filter Selections By"
    And I should see "None Selected"
    And I should see the "Filter Selections By" dropdown list with options "None Selected, Status, Errors"
    When I select "Status" as "filter_by"
    Then I should see the second "Status" dropdown list appear with default value "In Progress"
    And I should see the "Status" dropdown list with options "In Progress, Approved, Published, Ready to Review"
    And I should see "Clear filter"
    When I select "Errors" as "filter_by"
    And I wait for 2 seconds
    Then I should see the second "Errors" dropdown list appear with default value "Has Errors"
    And I should see the "Errors" dropdown list with options "Has Errors, No Errors, Needs Errors Check"
    And I should see "Clear filter"
    When I select "Status" as "filter_by"
    Then I should see the following 1 selections:
      |Title       |
      |selectionAAA|
    When I click the "Clear filter" link
    Then I should see "None Selected"
    And I should not see "filter_status"
    And I should not see "Clear filter"
    And I should see the following 4 selections:
      |Title       |
      |selectionDDD|
      |selectionCCC|
      |selectionBBB|
      |selectionAAA|
    When I select "Status" as "filter_by"
    And I select "Approved" as "filter_status"
    Then I should see the following 1 selections:
      |Title       |
      |selectionBBB|
    When I select "Status" as "filter_by"
    And I select "Ready to Review" as "filter_status"
    Then I should see the message "No slections to show with the current filter."

  @javascript
  Scenario: Filter selections with topics
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
      | 3  | selectionCCC | 2         | 2013-08-08 | 2013-08-08 | 1          | 100      |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    When I select "Status" as "filter_by"
    Then I should see the following 2 selections:
      | Title         | Status      | Last Edited By |
      | selectionBBB  | In Progress | Test Engineer  |
      | selectionAAA  | In Progress | Test Engineer  |
    When I click the "Clear filter" link
    Then I should see the following 3 selections:
      | Title           | Status      | Last Edited By |
      | selectionBBB    | In Progress | Test Engineer  |
      | selectionCCC    | Approved    | Test Engineer  |
      | selectionAAA    | In Progress | Test Engineer  |

  @javascript
  Scenario: can not sort selections that has been filtered
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And the following selections exist
      | id | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1  | selectionAAA | 1         | 2013-08-06 | 2013-08-06 | 1          | 1        |
      | 2  | selectionBBB | 1         | 2013-08-07 | 2013-08-07 | 1          | 1        |
      | 3  | selectionCCC | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
      | 4  | selectionDDD | 4         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    When I select "Status" as "filter_by"
    #And I drag "selectionCCC" to "top"
    # Then I should see the message "Selections and topics can only be reordered when not using a filter"
    When I select "None Selected" as "filter_by"
    And I should not see "filter_status"
    And I should not see "Clear filter"
    Then I should see the following 4 selections:
      |Title       |
      |selectionDDD|
      |selectionCCC|
      |selectionBBB|
      |selectionAAA|
