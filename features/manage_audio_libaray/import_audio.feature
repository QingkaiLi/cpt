@wip
Feature: import audio for those words with No Audio File status
  I should be able to change audio status, that's approve/reject/import audio 

  Background:
    Given the authentication provider "cas" of uid "123456" has user with name: "Test Engineer"

  @javascript
  Scenario: import audio and playback it
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
     When I click the audio icon for word "extremely"
     Then I should see a dialog named "Import Audio" with "Continue" and "Cancel" button
     And I check the filename provided for word "extremely"
     When I browse and select a file named "xxx.mp3" for word "extremely"
     And I click the "Continue" button
     Then I should see a dialog named "Audio Playback" for word "extremely"
     And I should see the <buttons> within the "Audio Playback" dialog
     | buttons       |
     | Approve Audio | 
     | Reject Audio  |
     When I click the "play" icon
     Then I should see the "play" icon is replaced by "pause" icon
     When I click the 'x' button 
     Then The audio icon for word "extremely" should be "yellow check" 
     
@javascript
  Scenario: import an invalid file
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
     When I click the audio icon for word "extremely"
     Then I should see a dialog named "Import Audio" with "Continue" and "Cancel" button
     And I check the filename provided for word "extremely"
     When I browse and select a file named "xxx.mv" for word "extremely"
     And I click the "Continue" button
     Then I should see an error message "The file could not be imported. Please try again."
     And I browse and select a file named "XXXXX.mp3" for word "extremely"
     And I click the "Continue" button
     Then I should see an error message "Filenames do not match. Please choose the matching file"
     When I click the 'x' button 
     Then The audio icon for word "extremely" should be "red X"

     

@javascript
  Scenario: check the Cancel button
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
     When I click the audio icon for word "extremely"
     Then I should see a dialog named "Import Audio" with "Continue" and "Cancel" button
     And I check the filename provided for word "extremely"
     When I browse and select a file named "xxx.mp3" for word "extremely"
     And I click the "Cancel" button
     Then I should not see any dialog displayed 
     When I click the audio icon for word "extremely"
     And I browse and select a file named "incorrect_name.mp3" for word "extremely"
     And I click the "Continue" button
     Then I should see an error message "Filenames do not match. Please choose the matching file"
     When I click the 'Cancel' button 
     Then The audio icon for word "extremely" should be "red X"

