Feature: Content packs have pagination
  1. The total number of content packs in the Content Pack List is displayed at the bottom
  2. The user can navigate between pages of the Content Pack List
  3. The user can select how many items are displayed per page via drop down. '10' is the default value for the drop down.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: When there is no content pack exists, I cannot see the bottom info including:
    total number, pagination, items per page.
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should not see the bottom info.


  @javascript
  Scenario: When there is any content pack exists, I can see the bottom info.
    Given the following content packs exist
      | name                | updated_at |
      | content pack one    | 2013-08-09 |
      | content pack two    | 2013-08-08 |
      | content pack theree | 2013-08-07 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see the bottom info.

  @javascript
  Scenario Outline: When there are many content packs exist, check the total number and page number.
    Given <total number> content packs exist
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see "Total: <total number>" and <page number> page number in the bottom

    Examples:
      | total number | page number |
      | 10           | 1           |
      | 11           | 2           |
      | 20           | 2           |
      | 29           | 3           |
      | 100          | 10          |
      | 200          | 10          |

  @javascript
  Scenario: When there are many content packs exist, check the function of pagination.
    Given 100 content packs exist
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see "Total: 100" and 10 page number in the bottom
    And the current page number is 1
    And the "previous page" link is inactive
    When I click "next page"
    Then the current page number is 2
    When I click "previous page"
    Then the current page number is 1
    When I click "2"
    Then the current page number is 2
    When I click "5"
    Then the current page number is 5
    When I click "next page"
    Then the current page number is 6
    When I click "8"
    Then the current page number is 8
    When I click "10"
    Then the current page number is 10
    And the "next page" link is inactive

  @javascript @wip
  Scenario: When there are many content packs exist, check the function of items per page
    Given 100 content packs exist
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see 10 content pack records in current page
    And I select "30" as "Item Per Page"
    Then I should see 30 content pack records in current page
    And I select "50" as "Item Per Page"
    Then I should see 50 content pack records in current page
    And I select "100" as "Item Per Page"
    Then I should see 100 content pack records in current page
    And I select "Show All" as "Item Per Page"
    Then I should see 100 content pack records in current page

