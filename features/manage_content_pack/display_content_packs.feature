Feature: Display content packs
  In order to know what content packs exist and what they contain
  As a Reading Assistant content administrator
  I should be able to browse content packs and see their contents

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: Browse content packs
    Given the following content packs exist
      | name               | updated_at |
      | content pack one   | 2013-08-07 |
      | content pack two   | 2013-08-06 |
      | content pack three | 2013-08-05 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see the "New Content Pack" button
    And I should see the "Manage Audio Library" button
    And I should see the following columns on content_table:
      | columns          |
      | Name             |
      | Description      |
      | Last Edited Date |
      | Type             |
      | Status           |
      | Created By       |
    And I should see the following content packs:
      | name               |
      | content pack one   |
      | content pack two   |
      | content pack three |
    And I should see the bottom info.

  @javascript
  Scenario: Browse content packs when there are no content packs
    Given I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see the message "Content Pack List is empty. Create new content packs." in the "content_packs_table"
    And I should not see the bottom info.

  @javascript
  Scenario: A title will appear when mouse over the delete/edit icon
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I hover over the edit icon for content pack content pack one
    Then I should see the title of edit icon: Edit Setting
    When I hover over the delete icon for content pack content pack two
    Then I should see the title of delete icon: Delete

  @javascript
  Scenario: If the content pack name is too long to display, it will be truncated with "..."
    Given the following content packs exist
      | name                              | updated_at |
      | content pack one very long name 1 | 2013-08-07 |
      | content pack one very long name 2 | 2013-08-06 |
      | content pack one very long name 3 | 2013-08-05 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then these content pack names should be truncated with "..."

