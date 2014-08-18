@wip
Feature: Pronunciation library have pagination
  1. The total number of items in the Word/Alternate Text column is displayed at the left bottom
  2. The user can navigate between pages of the pronuciation library by the page number or the left/right arrow
  3. The user can select how many items are displayed per page via drop down. '10' is the default value for the drop down.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario Outline: When there are many itmes in pronuciation library, check the total number and page number.
    Given <total number> pronuciations exist
    And I am in pronuciation library page
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
  Scenario: When there are many items exist in pronuciation library, check the function of pagination.
    Given 100 pronuciations exist
    And I am in pronuciation library page
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

  @javascript
  Scenario: When there are many items exist in pronuciation library, check the function of items per page
    Given 100 content packs exist
    And I am in pronuciation library page
    Then I should see 10 records in current page
    And I select "30" as "Item Per Page"
    Then I should see 30 records in current page
    And I select "50" as "Item Per Page"
    Then I should see 50 records in current page
    And I select "100" as "Item Per Page"
    Then I should see 100 records in current page
    And I select "Show All" as "Item Per Page"
    Then I should see 100 records in current page

