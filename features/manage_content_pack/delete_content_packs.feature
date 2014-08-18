Feature: Delete content packs
  As a Reading Assistant content administrator
  I should be able to delete content packs
  Only empty content packs can be deleted

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    And a user exists with name: "Test Engineer"
  @javascript
  Scenario: Click "No" button in "Delete Content Pack" dialog for empty content pack
    Given the following content packs exist
      | name               | updated_at |
      | content pack one   | 2013-08-07 |
      | content pack two   | 2013-08-06 |
      | content pack three | 2013-08-05 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see the "Delete" icon for "content pack"
    When I click the "Delete" icon for "content pack" with name "content pack one"
    Then I should see a pop up "confirm_delete" dialog with "No" button
    And I should see the message "Are you sure you want to delete the content pack one content pack?"
    And I click the "No" button
    Then I should not see a pop up "confirm_delete" dialog
    And I should see the following content packs:
      | name  |
      | content pack one   |
      | content pack two   |
      | content pack three |

  @javascript
  Scenario: Click "Yes" button in "Delete Content Pack" dialog for empty content pack
    Given the following content packs exist
      | name               | updated_at |
      | content pack one   | 2013-08-07 |
      | content pack two   | 2013-08-06 |
      | content pack three | 2013-08-05 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see the "Delete" icon for "content pack"
    When I click the "Delete" icon for "content pack" with name "content pack one"
    Then I should see a pop up "confirm_delete" dialog with "Yes" button
    And I should see the message "Are you sure you want to delete the content pack one content pack?"
    And I click the "Yes" button
    And I wait for 3 seconds
    Then I should not see the following content packs:
      | name  |
      | content pack one |


  @javascript
  Scenario: Click "Yes" button in "Delete Content Pack" dialog for non-empty content pack
    Given a user exists with name: "Test Engineer"
    Given the following content packs exist
      | id  | name               | content_type_id | description                | status_id | updated_at | user_id |
      |  1  | content pack one   | 1               | This is content pack one   | 1         | 2013-08-07 | 1       |
      |  2  | content pack two   | 2               | This is content pack two   | 1         | 2013-08-06 | 1       |
    Given the following selections exist
      | id  | title        | status_id | created_at | updated_at | updater_id | topic_id |
      | 1   | selectionAAA | 1         | 2013-08-08 | 2013-08-08 | 1          | 1        |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    When I click the "Delete" icon for "content pack" with name "content pack one"
    Then I should not see a pop up "confirm_delete" dialog
    Then I should see the notice text "The content pack content pack one cannot be deleted while it contains selections. Selections within the content pack must be deleted first."
    When I click the "Delete" icon for "content pack" with name "content pack two"
    Then I should see a pop up "confirm_delete" dialog with "Yes" button
    And I click the "Yes" button
    And I wait for 5 seconds
    Then I should see the following content packs:
        | name             |
        | content pack one |
