@wip
Feature: Search and filter words in Audio Library
As a content production contributor, I am able to search or filter criteria in the Audio Library

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
    Given a user exists with name: "Test Engineer"
  
  @javascript
  Scenario: Search words in Audio Library
    Given the following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And I am in Audio Library page
    Then I should see a "search" input text
    And I should see a "search" button
    When I type "hello" in "search" input text
    And I click the "search" button
    Then I should see a link "Clear Search" appear
    And I should see no words list in the table
    And I should see a message "No results were found matching the search criteria" in the table
    When I click the link "Clear Search"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And I should not see a link "Clear Search"
    When I type "t" in "search" input text
    And I click the "search" button
    Then I should seee following words exist
      | status        | enable | word                   | description     |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I type "th" in "search" input text
    And I click the "search" button
    Then I should seee following words exist
      | status        | enable | word                   | description     |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I select "30" in "Items Per Page"
    Then I should seee following words exist
      | status        | enable | word                   | description     |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I go to the Pronunciations Library page
    And I go to the audio Library page
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |

  @javascript
  Scenario: Filter words in Audio Library
    Given the following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And I am in Audio Library page
    Then I should see a "Filter Status By" dropdown list with default value "None Selected"
    When I click "Filter Status By"
    Then I should see the following options
      |None selected   |
      |No Audio        |
      |Needs Review    |
      |Approved        |
      |No Audio Enabled|
    When I click the option "No Audio"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | No Audio File |        | deinstitutionalization |                 |
    And I should see a link "Clear Filter" appear
    When I click the link "Clear Filter"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And I should not see a link "Clear Filter"
    And I should see a "Filter Status By" dropdown list with default value "None Selected"
    When I click the option "Needs Review"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Needs Review  |        | tangent                |                 |
    When I click the link "Clear Filter"
    And I click the option "Approved"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I Click the option "None selected"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I click the option "No Audio Enabled"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |  No    | the                    |                 |
    When I select "30" in "Items Per Page"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |  No    | the                    |                 |
    When I go to the Pronunciations Library page
    And I go to the audio Library page
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |

  @javascript
  Scenario: Search and Filter words in Audio Library
    Given the following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And I am in Audio Library page
    Then I should see a "search" input text
    And I should see a "search" button
    And I should see a "Filter Status By" dropdown list with default value "None Selected"
    When I type "th" in "search" input text
    And I click the "search" button
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I click the option "Needs Review"
    Then I should see no words list in the table
    And I should see a message "No results to show with the current filter" in the table
    When I click the link "Clear Filter"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I click the link "Clear Search"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I click the option "Approved"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    When I type "0" in "search" input text
    And I click the "search" button
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
    When I click the link "Clear Search"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
    And I type "d" in "search" input text
    And I click the "search" button
    Then I should see no words list in the table
    And I should see a message "No results were found matching the search criteria" in the table
    When I select "30" in "Items Per Page"
    Then I should see no words list in the table
    And I should see a message "No results were found matching the search criteria" in the table
    When I go to the Pronunciations Library page
    And I go to the audio Library page
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |

  @javascript
  Scenario: Search and Filter words in many pages
    Given the following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | No Audio File |        | deinstitutionalization |                 |
      | Needs Review  |        | tangent                |                 |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
      | Approved      |        | file                   |                 |
      | Approved      |        | search                 |                 |
      | Approved      |        | text                   |                 |
      | Approved      |        | default                |                 |
      | Approved      |        | page                   |                 |
      | Approved      |        | input                  |                 |
      | Approved      |        | list                   |                 |
      | Approved      |        | select                 |                 |
    And I am in Audio Library page
    Then I should see a "search" input text
    And I should see a "search" button
    And I should see a "Filter Status By" dropdown list with default value "None Selected"
    And I should see "Total: 13"
    And I should see the pagination with page count 1
    And I should see "30" in "Items Per Page"
    When I type "tangent" in "Search" input text
    And I click the "Search" button
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Needs Review  |        | tangent                |                 |
    And the current page number is 1
    When I click the link "Clear Search"
    And I click the option "Approved"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
      | Approved      |        | file                   |                 |
      | Approved      |        | search                 |                 |
      | Approved      |        | text                   |                 |
      | Approved      |        | default                |                 |
      | Approved      |        | page                   |                 |
      | Approved      |        | input                  |                 |
      | Approved      |        | list                   |                 |
      | Approved      |        | select                 |                 |
    And I should see the pagination with page count 1
    When I select "10" in "Items Per Page"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
      | Approved      |        | file                   |                 |
      | Approved      |        | search                 |                 |
      | Approved      |        | text                   |                 |
      | Approved      |        | default                |                 |
      | Approved      |        | page                   |                 |
      | Approved      |        | input                  |                 |
      | Approved      |        | list                   |                 |
    And I should see the pagination with page count 2
    When I click "next page"
    Then the current page number is 2
    And I should see following words exist
      | status        | enable | word                   | description     |            
      | Approved      |        | select                 |                 |
    When I select "30" in "Items Per Page"
    Then I should see following words exist
      | status        | enable | word                   | description     |
      | Approved      |        | 1500                   | fifteen hundred |
      | Approved      |  Yes   | the                    |                 |
      | Approved      |  No    | the                    |                 |
      | Approved      |        | file                   |                 |
      | Approved      |        | search                 |                 |
      | Approved      |        | text                   |                 |
      | Approved      |        | default                |                 |
      | Approved      |        | page                   |                 |
      | Approved      |        | input                  |                 |
      | Approved      |        | list                   |                 |
      | Approved      |        | select                 |                 |
    And I should see the pagination with page count 1

