@wip
Feature: For some words(expanded phrases, multiple recordings...), after approved, an Enable checkbox is listed for user to make it available for use in RA content.
  
  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"
      
@javascript
  Scenario: check the word color for the multiple words, and enable one of the audio for one word
    Given the following words exist
      | status         | enable |  word                   | description       |
      | Approved       |        |  1500                   | fifteen hundred   |
      | No Audio File  |        |  extremely              |                   |
      | Approved       |  Yes   |  do                     | do!1              |
      | Needs Review   |        |  do                     | do!2              |
      | Approved       |  No    |  st.                    | saint             |
      | Approved       |  No    |  st.                    | street            |
      | Approved       |  No    |  st.                    | special treatment |

     And the following pronunciations exist
      | status                | Word/Alternate Text    | Invalid Pronunciation                                                 |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Approved              | do!1                   | D UW                                                                  |
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Approved              | saint                  |                                                                       |
      | Approved              | street                 |                                                                       |
      | Approved              | special                |                                                                       |
      | Approved              | treatment              |                                                                       |
     And I am logged in with "CAS" 
     And I am in Word Audio and Pronunciations page
     Then I should see the word color of following words are red
      | word      | description       |
      | do        | do!1              |
      | do        | do!2              |
      | st.       | saint             |
      | st.       | street            |
      | st.       | special treatment |  
     When I enable the audio for word "do" with description "do!1"
     Then I should see the word color of following words are black
      | word      | description |
      | do        | do!1        |
      | do        | do!2        |


@javascript
  Scenario: More than one file can be enabled
    Given the following words exist
      | status         | enable |  word                   | description       |
      | Approved       |        |  1500                   | fifteen hundred   |
      | No Audio File  |        |  extremely              |                   |
      | Approved       |  Yes   |  do                     | do!1              |
      | Needs Review   |        |  do                     | do!2              |
      | Approved       |  Yes   |  st.                    | saint             |
      | Approved       |  NO    |  st.                    | street            |
      | Approved       |  No    |  st.                    | special treatment |

     And the following pronunciations exist
      | status                | Word/Alternate Text    | Invalid Pronunciation                                                 |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Approved              | do!1                   | D UW                                                                  |
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Approved              | saint                  |                                                                       |
      | Approved              | street                 |                                                                       |
      | Approved              | special                |                                                                       |
      | Approved              | treatment              |                                                                       |
     And I am logged in with "CAS" 
     And I am in Word Audio and Pronunciations page
     Then I should see the word color of following words are black
      | word      | description       |
      | st.       | saint             |
      | st.       | street            |
      | st.       | special treatment |  
     When I enable the audio for word "st." with description "street"
     Then I should see the word color of following words are black
      | word      | description       |
      | st.       | saint             |
      | st.       | street            |
      | st.       | special treatment | 
     When I enable the audio for word "st." with description "special treatment"
     Then I should see the word color of following words are black
      | word      | description       |
      | st.       | saint             |
      | st.       | street            |
      | st.       | special treatment | 


  @javascript
  Scenario: Disable all of the word audios, the word color should return back to red
    Given the following words exist
      | status         | enable |  word                   | description       |
      | Approved       |        |  1500                   | fifteen hundred   |
      | No Audio File  |        |  extremely              |                   |
      | Approved       |  Yes   |  do                     | do!1              |
      | Needs Review   |        |  do                     | do!2              |
      | Approved       |  Yes   |  st.                    | saint             |
      | Approved       |  Yes   |  st.                    | street            |
      | Approved       |  Yes   |  st.                    | special treatment |

     And the following pronunciations exist
      | status                | Word/Alternate Text    | Invalid Pronunciation                                                 |
      | Approved              | ﬁfteen                 | F IH F T IY N                                                         |
      | Needs Review          | extremely              | IX K S T R IY M L IY,  EH K S T R IY M L IY                           |
      | Approved              | thousand               | TH OW S AH N D                                                        |
      | Approved              | hundred                | HH AH N D R AX D,  HH AH N D R IX D,  HH AH N AXR D,  HH AH N D AXR D |
      | Approved              | do!1                   | D UW                                                                  |
      | Invalid Pronunciation | do!2                   |                                                                       |
      | Approved              | saint                  |                                                                       |
      | Approved              | street                 |                                                                       |
      | Approved              | special                |                                                                       |
      | Approved              | treatment              |                                                                       |
     And I am logged in with "CAS" 
     And I am in Word Audio and Pronunciations page
     When I disable all audios for word "st."
     Then I should see the word color of following words are red
      | word      | description       |
      | st.       | saint             |
      | st.       | street            |
      | st.       | special treatment | 

