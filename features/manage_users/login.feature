Feature: Login CPT
   To access CPT I must be authorized first.
   CPT will use CAS of MyScilearn to authenticate.

  @focus
  Scenario Outline: Login CPT with MSL user
    Given the authentication provider "<provider>" of uid "<uid>" has user with name: "<name>"
    And I am logged in with "<provider>"
    When I visit "/"
    Then I should see "<name>"
    And I should see "Logout"

    Examples:
      | provider | uid    | name          |
      | cas      | 12345  | Test Engineer |
      | cas      | 123456 | Dev Engineer  |
      | cas      | 5689   | Manager       |

