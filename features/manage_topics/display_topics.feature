Feature: Display topics
  As a Reading Assistant content administrator
  I should be able to browse topics and see their contents

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"

  @javascript
  Scenario: Browse topic page when there is no topics and no selections
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    When I login and go to the topic page of content pack "content pack one"
    Then I should see the "< BACK TO CONTENT PACKS" link
    And I should see the "New Topic" button
    And I should see the "New Selection" button
    And I should see the following columns on topic_header:
      |columns          |
      |Title            |
      |Grade Level      |
      |Status           |
      |Last Edited Date |
      |Last Edited By   |
      |Errors           |
    And I should see the message "Content Pack is empty. Create new topics, new selections, or import existing selections." in the "topics_list"

  @javascript
  Scenario: Browse topics when there are only selections
    Given a user exists with name: "Test Engineer"
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
    And I wait for 3 seconds
    And I should see the following 3 selections:
      | Title        | Status      | Last Edited By |
      | selectionCCC | In Progress | Test Engineer  |
      | selectionBBB | In Progress | Test Engineer  |
      | selectionAAA | In Progress | Test Engineer  |

  @javascript
  Scenario: Browse topics when there are only topics
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
   And the following topics exist
      | name        | content_pack_id | grade_level | created_at |
      | topic one   | 1               | 1.9         | 2013-08-07 |
      | topic two   | 2               | 2.0         | 2013-08-08 |
      | topic three | 1               | 3.9         | 2013-08-09 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    Then I should see the following 2 topics:
      | Title           | Grade Level |
      | topic three (0) | 3.9         |
      | topic one (0)   | 1.9         |
    When I click the "< BACK TO CONTENT PACKS" link
    And I click the content pack "content pack two"
    And I wait for 3 seconds
    Then I should see the following 1 topics:
      | Title         | Grade Level |
      | topic two (0) | 2.0         |

  @javascript
  @wip
  Scenario: Browse topics when there are topics and selections
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
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    Then I should see the following 2 topics:
      | Title           | Grade Level |
      | topic three (0) | 3.9         |
      | topic one (2)   | 1.9         |
    And I should see the following 2 selections listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionBBB | In Progress | 08/07/2013       | Test Engineer  |
      | selectionAAA | In Progress | 08/06/2013       | Test Engineer  |
    When I click the "< BACK TO CONTENT PACKS" link
    And I click the content pack "content pack two"
    And I wait for 3 seconds
    Then I should see the following 1 topic:
      | Title         | Grade Level |
      | topic two (1) | 2.0         |
    And I should see the following 1 selections listed in "topic two":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionCCC | In Progress | 08/08/2013       | Test Engineer  |

  @javascript
  Scenario: Clicking "< BACK TO CONTENT PACKS" in a topic page should bring back content pack page
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "content pack one"
    Then I should see the "< BACK TO CONTENT PACKS" link
    When I click the "< BACK TO CONTENT PACKS" link
    Then I should see the following content packs:
      | name             |
      | content pack one |
      | content pack two |


  @javascript
  Scenario: Check the topic arrow icon when there are selections under one topic
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
    And I click the content pack "content pack one"
    And I wait for 3 seconds
    Then I should see the following 2 selections listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionBBB | In Progress | 08/07/2013       | Test Engineer  |
      | selectionAAA | In Progress | 08/06/2013       | Test Engineer  |
    When I click the arrow icon of topic topic one
    Then I should not see the following 2 selections listed in "topic one":
      | Title        | Status      | Last Edited Date | Last Edited By |
      | selectionBBB | In Progress | 08/07/2013       | Test Engineer  |
      | selectionAAA | In Progress | 08/06/2013       | Test Engineer  |

