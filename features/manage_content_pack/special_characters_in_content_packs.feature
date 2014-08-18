Feature: Special characters support
  When there are special characters in Content pack name or description, the behavior should bot be corrupted.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario Outline: Create a new content pack with special characters in content pack name and description
    Given I open the New Content Pack dialog
    When I type "<name>" as "Name"
    And I select "<type>" as "Type"
    And I type "<description>" as "description"
    And I click the "Save" button
    And I wait for 5 seconds
    Then I should see the "<name>" content pack created:
      | name   | description  | type   | status      | created_by    |
      | <name> | <description>| <type> | In Progress | Test Engineer |
    When I hover over the content pack name <name>
    Then I should see the title of content pack name <name>

    Examples:
      | name                                        | type               | description         |
      | <script>document.body.innerHTML=''</script> | Fluency Assessment | "I'm a description" |
      | <div>hello</div>                            | Fluency Assessment | "I'm a description" |
      | ~!@#$%^&*()_+                               | Fluency Assessment | "I'm a description" |
      | But;Fly                                     | Fluency Assessment | "I'm a description" |

  @javascript
  Scenario Outline: Delete content pack with special characters in content pack name
    Given the following content packs exist
      | name                                        | updated_at |
      | <div>hello</div>                            | 2013-08-07 |
      | <script>document.body.innerHTML=1</script> | 2013-08-06 |
      | a;b                                         | 2013-08-05 |
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    Then I should see the "Delete" icon for "content pack"
    When I click the "Delete" icon for "content pack" with name "<name>"
    Then I should see the message "Are you sure you want to delete the <name> content pack?" in the "content_packs_delete_confirm"
    When I click the "Yes" button
    And I wait for 5 seconds
    Then I should not see the following content packs:
      | name   |
      | <name> |

    Examples:
      | name                                       | updated_at |
      | <div>hello</div>                           | 2013-08-07 |
      | <script>document.body.innerHTML=1</script> | 2013-08-06 |
      | a;b                                        | 2013-08-05 |


