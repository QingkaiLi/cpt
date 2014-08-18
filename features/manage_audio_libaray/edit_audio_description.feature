@wip
Feature: User can add, edit, or delete content within the description
  
  The user must double-click a description to make it editable.

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: edit content for one word's description
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
     When I double click the description for word "extremely"
     And I type "extremely  " as description
     And I press Enter key
     And I double click the description for word "1500"
     And I type " one thousand and five hundred " as description
     And I click the other line to save it
     Then I should see the following words
      | Approved       |        |  1500                   |  one thousand and five hundred  |
      | No Audio File  |        |  extremely              |  extremely                      |
      | Approved       |  Yes   |  do                     |  do!1                           |
      | Needs Review   |  No    |  do                     |  do!2                           |
     When I double click the description for word "do" with description "do!1"
     And I type "  " as description
     And I press Enter key
     Then I should see the following words
      | Approved       |        |  1500                   |  one thousand and five hundred  |
      | No Audio File  |        |  extremely              |  extremely                      |
      | Approved       |  Yes   |  do                     |                                 |
      | Needs Review   |  No    |  do                     |  do!2                           |
      
  @javascript
  Scenario Outline: check length of word's description
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
     When I double click the description for word "extremely"
     And I type <type_desc_length> chars as description
     And I press Enter key
     Then the "description" length should be "<correct_desc_length>"
     Examples:
      | type_desc_length | correct_desc_length |
      | 1                | 1                   |
      | 100              | 100                 |
      | 256              | 256                 |
      | 1000             | 256                 |


  @javascript
  Scenario Outline: check special characters of word's description
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
     When I double click the description for word "extremely"
     And I type "<type_desc>" as description
     And I press Enter key
     Then I should see the following words
      | status         | enable |  word                   |  description      |
      | Approved       |        |  1500                   |  fifteen hundred  |  
      | No Audio File  |        |  extremely              |  <type_desc>      |  
      | Approved       |  Yes   |  do                     |  do!1             |
      | Needs Review   |  No    |  do                     |  do!2             |

     Examples:
      | type_desc                                   | 
      | <html>alert("aaa")</html>                   |
      | <script>document.body.innerHTML=''</script> |
      | select * from audios;                       |
      | A\|'B'\|~!@#$%^&*()_+                       |

