Feature: Sort content packs
  The content packs are sorted by Last edited date,
  by default, with the most recent date on top.
  The user may choose to sort by Name, Type, Status, or Created by instead

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    When the following users exist
      | name          | provider | uid |
      | Aest Engineer | cas      | 123 |
      | Best Engineer | cas      | 456 |
    And the following content packs exist
      | id | name                 | content_type_id | description                | status_id | user_id | updated_at |
      | 1  | a content pack one   | 1               | This is content pack one   | 1         | 1       | 2013-08-01 |
      | 2  | b content pack two   | 2               | This is content pack two   | 2         | 2       | 2013-08-05 |
      | 3  | c content pack three | 1               | This is content pack three | 3         | 2       | 2013-08-04 |
    And I am logged in with "CAS"

  @javascript
  Scenario: The default order is by Last Edited Date with the most recent date top.
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |


  @javascript
  Scenario: Sort by content pack name
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |
    And I click the column header "Name"
    Then I should see the following content packs:
      | name                 |
      | a content pack one   |
      | b content pack two   |
      | c content pack three |
    When I click the column header "Name"
    Then I should see the following content packs:
      | name                 |
      | c content pack three |
      | b content pack two   |
      | a content pack one   |

  @javascript
  Scenario: Sort by last edited date
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |
    And I click the column header "Last Edited Date"
    Then I should see the following content packs:
      | name                 |
      | a content pack one   |
      | c content pack three |
      | b content pack two   |
    When I click the column header "Last Edited Date"
    Then I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |

  @javascript
  Scenario: Sort by content type
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |
    And I click the column header "Type"
    Then I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |
    When I click the column header "Type"
    Then I should see the following content packs:
      | name                 |
      | c content pack three |
      | a content pack one   |
      | b content pack two   |

  @javascript
  Scenario: Sort by status
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |
    And I click the column header "Status"
    Then I should see the following content packs:
      | name                 |
      | b content pack two   |
      | a content pack one   |
      | c content pack three |
    When I click the column header "Status"
    Then I should see the following content packs:
      | name                 |
      | c content pack three |
      | a content pack one   |
      | b content pack two   |

  @javascript
  Scenario: Sort by created by
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |
    And I click the column header "Created By"
    Then I should see the following content packs:
      | name                 |
      | a content pack one   |
      | b content pack two   |
      | c content pack three |
    When I click the column header "Created By"
    Then I should see the following content packs:
      | name                 |
      | b content pack two   |
      | c content pack three |
      | a content pack one   |

