@wip
Feature: Reject audio for those words with Needs Review status or Approve status
  I should be able to change audio status, that's approve/reject/import audio 

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: reject the Needs Review audio, changing to Missing audio status
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
     When I click the audio icon for word "do" with description "do!2"
     Then I should see a dialog named "Audio Playback" with "Approve Audio" and "Reject Audio" button
     When I click the "Reject Audio" button
     Then I should see a dialog named "Reject Audio" for word "do(do!2)"
     And I should see the <buttons> within the "Reject Audio" dialog
     | buttons |
     | Yes     | 
     | No      |
     And I should see the message "Are you sure you want to reject audio for the following: Word"
     When I click the "Yes" button
     Then I should not see any dialog displayed
     And The audio icon for word "do" with description "do!2" should be "red X"


  @javascript
  Scenario: reject the Approved audio, changing to Missing audio status
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
     When I click the audio icon for word "do" with description "do!1"
     Then I should see a dialog named "Audio Playback" with "Reject Audio" button for word "do!1"
     And I should see the "Approve Audio" button is replaced by the message "Approved by: Test Engineer" 
     When I click the "Reject Audio" button
     Then I should see a dialog named "Reject Audio" for word "do(do!1)"
     And I should see the <buttons> within the "Reject Audio" dialog
      | buttons |
      | Yes     | 
      | No      |
     And I should see the message "Are you sure you want to reject audio for the following: Word"
     When I click the "Yes" button
     Then I should not see any dialogs displayed
     And The audio icon for word "do" with description "do!1" should be "red X"


  @javascript
  Scenario: click No button while rejecting the Approved audio
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
     When I click the audio icon for word "do" with description "do!1"
     Then I should see a dialog named "Audio Playback" with "Reject Audio" button for word "do!1"
     And I should see the "Approve Audio" button is replaced by the message "Approved by: Test Engineer" 
     When I click the "Reject Audio" button
     Then I should see a dialog named "Reject Audio" for word "do(do!1)"
     And I should see the <buttons> within the "Reject Audio" dialog
      | buttons |
      | Yes     | 
      | No      |
     And I should see the message "Are you sure you want to reject audio for the following: Word"
     When I click the "No" button
     Then I should see a dialog named "Audio Playback" with "Reject Audio" button for word "do(do!1)"
     When I click the 'x' button
     Then I should not see any dialog displayed
     And The audio icon for word "do" with description "do!1" whould be "blue check"


  @javascript
  Scenario: click No button while rejecting the Needs Review audio
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
     When I click the audio icon for word "do" with description "do!2"
     Then I should see a dialog named "Audio Playback" for word "do(do!2)"
     And I should see the <buttons> within the "Audio Playback" dialog
     | buttons       |
     | Approve Audio | 
     | Reject Audio  |
     When I click the "Reject Audio" button
     Then I should see a dialog named "Reject Audio"  for word "do(do!2)"
     And I should see the <buttons> within the "Reject Audio" dialog
      | buttons |
      | Yes     | 
      | No      |
     And I should see the message "Are you sure you want to reject audio for the following: Word"
     When I click the "No" button
     Then I should see a dialog named "Audio Playback" for word "do(do!2)"
     When I click the 'x' button
     Then I should not see any dialog displayed
     And The audio icon for word "do" with description "do!2" should be "yellow check"

