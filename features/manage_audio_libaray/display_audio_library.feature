@wip
Feature: Display audio library
  In order to know what audios exist and what they contain
  As a Reading Assistant content administrator
  I should be able to browse audio library and see their contents

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: Browse audio library
    Given the following words exist
      | status         | enable |  word                   |  description      |
      | Approved       |        |  1500                   |  fifteen hundred  |
      | No Audio File  |        |  extremely              |                   |
      | Approved       |  Yes   |  do                     |  do!1             |
      | Needs Review   |  No    |  do                     |  do!2             |
     And the following pronunciations exist
      | status                | Word/Alternate Text    | Invalid Pronunciation                                                 |                                   
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Approved              | do!1                   | D UW                                                                  |
      | Invalid Pronunciation | do!2                   |                                                                       |
     And I am logged in with "CAS" 
     And I am in Word Audio and Pronunciations page
     Then I should see the following columns on audio_table
      | columns          |
      | Enable           |
      | Word             |
      | Description      |
     And I should see the following words
      | Approved       |        |  1500                   |  fifteen hundred  |
      | No Audio File  |        |  extremely              |                   |
      | Approved       |  Yes   |  do                     |  do!1             |
      | Needs Review   |  No    |  do                     |  do!2             |
     And I should see the bottom info.


  @javascript
  Scenario Outline: Check the audio icon for the 3 kinds of status
      Given the following words exist
      | status         | enable |  word                   |  description      |
      | Approved       |        |  1500                   |  fifteen hundred  |
      | No Audio File  |        |  extremely              |                   |
      | Approved       |  Yes   |  do                     |  do!1             |
      | Needs Review   |  No    |  do                     |  do!2             |
      And the following pronunciations exist
      | status                | Word/Alternate Text    | Invalid Pronunciation                                                 |                                   
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Approved              | do!1                   | D UW                                                                  |
      | Invalid Pronunciation | do!2                   |                                                                       |
     And I am logged in with "CAS" 
     And I am in Word Audio and Pronunciations page
     Then The audio icon for word "<word>" with description "<description>" should be "expect_icon"
     When I mouse over to the audio icon of word "<word>" with description "<description>"
     Then I can see the title message "<expect_title>"      
     Examples: 
      | word      | description | expect_icon  | expect_title  |
      | 1500      | 1500        | blue check   | Approved      |
      | extremely |             | red X        | No Audio File |
      | do        | do!1        | blue check   | Approved      |
      | do        | do!2        | yellow check | Needs Review  |


@javascript
  Scenario: Browse audio library when there are no items in audio library
    Given There are no items in audio library
    And I am in Word Audio and Pronunciations page
    Then I should see an empty table with no items.

