@wip
Feature: The Pronunciation Status icon has three states depending on whether pronunciation is available/approved.
  1. Missing pronunciation
  2. Needs Review
  3. Approved


  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: When pronunciation is available, but requires review from the user,
    selecting the Needs Review icon will open a modal window,
    allowing the user to approve pronunciation
    Given the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Needs Review          | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I am in pronuciation library page
    When I hover over "Needs Review" icon for "extremely"
    Then I will see the tip "Needs Review"
    When I click the "Needs Review" icon for "pronuciation" with name "extremely"
    Then a "Approve Pronunciation" dialog will pop up
    And I should see the message "Do you want to approve pronunciation for the following:"
    And I should see the message "Word/Alternate Text: extremely"
    And I should see the <buttons> within the "Approve Pronunciation" dialog
      | buttons |
      | Save    |
      | Cancel  |
    When I click the "Yes" button
    Then it will change the status to "Approved" and close the dialog
    When I click the "Needs Review" icon for "pronuciation" with name "thousand"
    Then a "Approve Pronunciation" dialog will pop up
    And I should see the message "Do you want to approve pronunciation for the following:"
    And I should see the message "Word/Alternate Text: thousand"
    And I should see the <buttons> within the "Approve Pronunciation" dialog
      | buttons |
      | Save    |
      | Cancel  |
    When I click the "No" button
    Then it will not change the status and close the dialog

  Scenario: When pronunciation is available and approved, the Approved icon will be
    displayed. On mouseover, the username is displayed for who approved the pronunciation.
    The icon is not selectable.
    Given the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Needs Review          | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I am in pronuciation library page
    When I hover over "Approved" icon for "fifteen"
    Then I will see the tip "Approved by xxxx"
    When I click the "Approved" icon for "pronuciation" with name "fifteen"
    Then I can see nothing change

  Scenario: When there is no pronunciation or there are pronunciations with errors,
    the Invalid Pronunciation icon will be displayed. The icon is not selectable.
    Given the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Needs Review          | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I am in pronuciation library page
    When I hover over "Invalid Pronunciation" icon for "deinstitutionalization"
    Then I will see the tip "Invalid Pronunciation"
    When I click the "Invalid Pronunciation" icon for "pronuciation" with name "deinstitutionalization"
    Then I can see nothing change


