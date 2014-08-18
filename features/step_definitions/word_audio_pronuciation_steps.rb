Given(/I am in Word Audio and Pronunciations page$/) do
  steps %{
    Given I am logged in with "CAS"
    When I go to the Content Production Tool Index page
    Then I should see the "More Actions" dropdown menu
    When I click the "Word Audio Dicitionary" in "More Actions" dropdown menu
    Then I should go to the "Word Audio and Pronunciations" page
  }
end

Given(/I am in pronuciation library page$/) do
  steps %{
    Given I am in Word Audio and Pronunciations page
    Then I should see the "Pronunciation Library" button
    When I click the "Pronunciation Library" button
    Then I should go to the "Pronunciation Library" page
  }
end

When(/^I click the "(.*?)" in "(.*?)" dropdown menu$/) do |choice, dropdown|
  steps %{
    And I click the "#{dropdown}" button
  }
  find("a", :text => choice).click
end

Then(/^I should go to the "(.*?)" page$/) do |page_name|
  page.should have_content page_name
end

