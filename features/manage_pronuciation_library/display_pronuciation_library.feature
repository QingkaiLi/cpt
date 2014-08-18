@wip
Feature: Display pronuciation library
  In order to know the pronuciations associated with 'recognizer' words.
  As a Reading Assistant content administrator
  I should be able to browse pronuciation library and see their contents

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: Browse pronuciation library
    Given the following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    Given I am logged in with "CAS"
    When I go to the Content Production Tool Index page
    Then I should see the "More Actions" dropdown menu
    When I click the "Word Audio Dicitionary" in "More Actions" dropdown menu
    Then I should go the "Word Audio and Pronunciations" page
    And I should see the "Pronunciation Library" button
    When I click the "Production Library" button
    Then I should go to the "Pronunciation Library" page
    And I should see the following columns on pronunciation_library_table:
      | columns               |
      | Status                |
      | Word/Alternate Text   |
      | Pronunciation         |
    And I should see the following pronuciations:
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Approved              | thousand               | TH OW S AH N D                                                        |
    And I should see the total number of items in the Word/Alternate Text is 5
    And I should see the "Item per page" dropdown menu with "10,30,50,100,Show All" options
    And I should see the pagination with page count 1


  @javascript
  Scenario: Browse pronuciation library when there are no items in pronuciation library
    Given There are no items in pronuciation library
    And I am in pronuciation library page
    Then I should see an empty table with no items.

