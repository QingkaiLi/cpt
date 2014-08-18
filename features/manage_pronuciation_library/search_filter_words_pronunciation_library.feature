@wip
Feature: Search and filter words in Pronunciation Library
As a content production contributor, I am able to search or filter criteria in the Pronunciation Library

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"
  
  @javascript
  Scenario: Search words in Pronunciation Library
    Given the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I amd in Pronunciation Library
    Then I should see a "search" input text
    And I should see a "search" button
    When I type "hello" in "search" input text
    And I click the "search" button
    Then I should see a link "Clear Search" appear
    And I should see no words list in the table
    And I should see a message "No results were found matching the search criteria" in the table
    When I click the link "Clear Search"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I should not see a link "Clear Search"
    When I type "t" in "search" input text
    And I click the "search" button
    Then I should seee following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
    When I type "th" in "search" input text
    And I click the "search" button
    Then I should seee following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | thousand               | TH OW S AH N D                                                        |
    When I select "30" in "Items Per Page"
    Then I should seee following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | thousand               | TH OW S AH N D                                                        |
    When I go to the Pronunciations Library page
    And I go to the audio Library page
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
 
  @javascript
  Scenario: Filter words in Pronunciation Library
    Given the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I am in Pronunciation Library page
    Then I should see a "Filter Status By" dropdown list with default value "None Selected"
    When I click "Filter Status By"
    Then I should see the following options
      |None selected        |
      |Missing Pronunciation|
      |Needs Review         |
      |Approved             |
    When I click the option "Missing Pronunciation"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
    And I should see a link "Clear Filter" appear
    When I click the link "Clear Filter"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I should not see a link "Clear Filter"
    And I should see a "Filter Status By" dropdown list with default value "None Selected"
    When I click the option "Needs Review"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
    When I click the link "Clear Filter"
    And I click the option "Approved"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    When I Click the option "None selected"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    When I click the option "Needs Review"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
    When I select "30" in "Items Per Page"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
    When I go to the Audio Library page
    And I go to the Pronunciations Library page
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |

  @javascript
  Scenario: Search and Filter words in Pronunciation Library
    Given the following pronunciations exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I am in Pronunciation Library page
    Then I should see a "search" input text
    And I should see a "search" button
    And I should see a "Filter Status By" dropdown list with default value "None Selected"
    When I type "th" in "search" input text
    And I click the "search" button
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | thousand               | TH OW S AH N D                                                        |
    When I click the option "Needs Review"
    Then I should see no words list in the table
    And I should see a message "No results to show with the current filter" in the table
    When I click the link "Clear Filter"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | thousand               | TH OW S AH N D                                                        |
    When I click the link "Clear Search"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    When I click the option "Approved"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    When I type "een" in "search" input text
    And I click the "search" button
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | fifteen                | F IH F T IY N                                                         |
    When I click the link "Clear Search"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
    And I type "some" in "search" input text
    And I click the "search" button
    Then I should see no words list in the table
    And I should see a message "No results were found matching the search criteria" in the table
    When I select "30" in "Items Per Page"
    Then I should see no words list in the table
    And I should see a message "No results were found matching the search criteria" in the table
    When I go to the Audio Library page
    And I go to the Pronunciations Library page
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |
      | Invalid Pronunciation | deinstitutionalization |                                                                       |
      | Approved              | fifteen                | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |

  @javascript
  Scenario: Search and Filter words in many pages
    Given the following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |                              
      | Invalid Pronunciation | deinstitutionalization |                                                                       |                              
      | Approved              | fifteen                | F IH F T IY N                                                         |                              
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           | 
      | Approved              | thousand               | TH OW S AH N D                                                        |                              
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Invalid Pronunciation | to                     |                                                                       | 
      | Invalid Pronunciation | too                    |                                                                       | 
      | Invalid Pronunciation | two                    |                                                                       | 
      | Invalid Pronunciation | do!1                   |                                                                       | 
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Invalid Pronunciation | list                   |                                                                       |
      | Invalid Pronunciation | search                 |                                                                       |
      | Invalid Pronunciation | text                   |                                                                       | 
      | Invalid Pronunciation | page                   |                                                                       |
      | Invalid Pronunciation | default                |                                                                       |
    And I am in Pronunciation Library page
    Then I should see a "search" input text
    And I should see a "search" button
    And I should see a "Filter Status By" dropdown list with default value "None Selected"
    And I should see "Total: 15"
    And I should see the pagination with page count 1
    And I should see "30" in "Items Per Page"
    When I type "to" in "Search" input text
    And I click the "Search" button
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          | 
      | Invalid Pronunciation | to                     |                                                                       | 
    And the current page number is 1
    When I click the link "Clear Search"
    And I click the option "Invalid Pronunciation"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |                              
      | Invalid Pronunciation | deinstitutionalization |                                                                       | 
      | Invalid Pronunciation | to                     |                                                                       | 
      | Invalid Pronunciation | too                    |                                                                       | 
      | Invalid Pronunciation | two                    |                                                                       | 
      | Invalid Pronunciation | do!1                   |                                                                       | 
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Invalid Pronunciation | list                   |                                                                       |
      | Invalid Pronunciation | search                 |                                                                       |
      | Invalid Pronunciation | text                   |                                                                       | 
      | Invalid Pronunciation | page                   |                                                                       |
      | Invalid Pronunciation | default                |                                                                       |
    And I should see the pagination with page count 1
    When I select "10" in "Items Per Page"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |                              
      | Invalid Pronunciation | deinstitutionalization |                                                                       | 
      | Invalid Pronunciation | to                     |                                                                       | 
      | Invalid Pronunciation | too                    |                                                                       | 
      | Invalid Pronunciation | two                    |                                                                       | 
      | Invalid Pronunciation | do!1                   |                                                                       | 
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Invalid Pronunciation | list                   |                                                                       |
      | Invalid Pronunciation | search                 |                                                                       |
      | Invalid Pronunciation | text                   |                                                                       |
      | Invalid Pronunciation | page                   |                                                                       |
    And I should see the pagination with page count 2
    When I click "next page"
    Then the current page number is 2
    And I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |  
      | Invalid Pronunciation | default                |                                                                       |
    When I select "30" in "Items Per Page"
    Then I should see following words exist
      | status                | Word/Alternate Text    | pronuciation                                                          |                              
      | Invalid Pronunciation | deinstitutionalization |                                                                       | 
      | Invalid Pronunciation | to                     |                                                                       | 
      | Invalid Pronunciation | too                    |                                                                       | 
      | Invalid Pronunciation | two                    |                                                                       | 
      | Invalid Pronunciation | do!1                   |                                                                       | 
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Invalid Pronunciation | list                   |                                                                       |
      | Invalid Pronunciation | search                 |                                                                       |
      | Invalid Pronunciation | text                   |                                                                       | 
      | Invalid Pronunciation | page                   |                                                                       |
      | Invalid Pronunciation | default                |                                                                       |
    And I should see the pagination with page count 1

