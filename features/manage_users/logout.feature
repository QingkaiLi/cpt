Feature: Log out CPT
  As a content production contributor,
  I can log out CPT.

  @focus
  Scenario Outline: Log out CPT
    Given the authentication provider "<provider>" of uid "<uid>" has user with name: "<name>"
    And I am logged in with "<provider>"
    Then I should see "Logout"
    When I am logged out
    Then I should not see "Logout"
    Then I should be redirected to "/login"
    And I should see "Please login to view contents."

    Examples:
      | provider | uid    | name          |
      | cas      | 1234   | Test Engineer |
      | cas      | 123456 | Dev Engineer  |
      | cas      | 1236   | Sales Engineer  |
