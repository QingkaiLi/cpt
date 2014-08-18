Given(/^the authentication provider: "(.*?)" has #{capture_fields}$/) do |provider, attrs|
  opts = attrs.split(',').reduce({}) do |h, field|
    k, v = field.split ':'
    h[k.strip.to_sym] = v
    h
  end
  OmniAuth.config.add_mock provider.to_sym, opts
end

Given(/^the authentication provider "(.*?)" of uid "(.*?)" has user with #{capture_fields}$/) do |provider, uid, attrs|
  info = attrs.split(',').reduce({}) do |h, field|
    k, v = field.split ':'
    h[k.strip.to_sym] = v.gsub /"/, ''
    h
  end
  OmniAuth.config.add_mock provider.to_sym, uid: uid, info: info
end

Given(/^I am logged in with "(.*?)"$/) do |provider|
  visit login_path
  visit "/auth/#{provider.downcase}"
end


Given(/^I am logged out$/) do
  visit "/#{logout_path}"
end

When /^I visit "([^"]*)"$/ do |path|
  visit path
end

When(/^I go to the Content Production Tool Index page$/) do
  visit root_path
  @app = App.new
end

When(/^I click the "(.*?)" (?:link|button)$/) do |locator|
  if (locator == 'x')
    locator = 'div.aui_dialog a.aui_close'
  end
  click_on locator
end

When(/^I click the "(.*?)" icon for "(.*?)" with name "(.*?)"$/) do |icon, object, name|
  if object =='content pack'
    classname=(icon=='Delete')?'icon-delete':'icon-edit'
    for_tag = (icon=='Delete')?'delete-for':'edit-for'
    page.find(:xpath, "//a[contains(@class,\'#{classname}\') and @#{for_tag}=\'#{name}\']").click
  elsif object == 'topic'
    for_tag = (icon=='Delete')?'delete-for':'edit-for'
    classname=(icon=='Delete')?'icon-delete topic-delete':'icon-edit topic-edit'
    page.find(:xpath, "//a[contains(@class,\'#{classname}\') and @#{for_tag}=\'#{name}\']").click
  elsif object == 'selection'
    for_tag = (icon=='Delete')?'delete-for':'edit-for'
    classname=(icon=='Delete')?'icon-delete selection-delete':'icon-edit selection-edit'
    if icon == 'CopyMove'
      classname = 'icon-copy-move'
      for_tag = 'move-copy-for'
    end
    page.find(:xpath, "//a[contains(@class,\'#{classname}\') and @#{for_tag}=\'#{name}\']").click
  else
    # the object is selection
    classname=(icon=='Delete')?'selection-delete':'selection-delete'
    page.find(:xpath, "//a[contains(@class,\'#{classname}\') and @data-name=\'#{name}\']").click
  end
end

Then(/^I should see the "(.*?)" icon for "(.*?)"$/) do |icon,name|
  if name == 'content pack'
    classname=(icon=='Delete')?'icon-delete':'icon-edit'
    page.should have_css "td>a.#{classname}"
  elsif name == 'topic'
    classname=(icon=='Delete')?'topic-delete':'topic-edit'
    page.should have_css ".col-title>a.#{classname}"
  elsif name == 'selection'
    # icon for selection
    classname=(icon=='Delete')?'selection-delete':'selection-edit'
    if icon == 'CopyMove'
      classname = 'icon-copy-move'
    end
    page.should have_css ".col-title>a.#{classname}"
  end
end

Then(/^I should see the message "([^"]*?)"$/) do |expected_message|
  page.should have_content expected_message
end

Then /^I should (not\s+)?see "([^"]*)"$/ do |negation, content|
  if negation
    page.should_not have_content content
  else
    page.should have_content content
  end
end

Then(/^I should see the "(.*?)" disappeared$/) do |element|
  page.should have_no_selector "div##{element}"
end

Then(/^I should see the "(.*?)" button$/) do |button|
  page.should have_link_or_button button
end

Then(/^I should be redirected to "(.*?)"$/) do |url|
  current_path.should == url
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

When(/^I am debugging$/) do
  debugger
end

Then(/^I should see a pop up dialog named "(.*?)"$/) do |name|
  case name
  when 'New Selection'
    cssname = 'div.aui_state_focus div.aui_inner'
  when 'New Content Pack'
    cssname = "#new_content_packs_dialog .aui_title"
  when 'New Topic'
    # @app.topic_page.new_topic_dialog
    cssname = 'div#new_topic_dialog table.aui_dialog'
  when 'Edit Content Pack Settings'
    # Edit Content Pack Settings
    cssname = "#edit_content_packs_dialog .aui_title"
  when 'Delete Topic'
    cssname ="div.aui_state_focus .aui_title"
  when 'Edit Topic Settings'
    cssname ="div.aui_state_focus div.aui_title"
  when 'Edit Selection Settings'
    cssname = "#edit_selection_dialog div.aui_title"
  when "Delete Selection"
    cssname ="div.aui_state_focus div.aui_title"
  when "Move/Copy Selection"
    cssname ="div.aui_state_focus div.aui_title"
  end
  within("#{cssname}") do
    page.should have_content name
  end
end

Then(/^I should see the "(.*?)" dropdown list with options "(.*?)"$/) do |label, options|
  #  label_element = page.find('label', text: label)
  case label
  when 'Content Packs'
    select_element = page.find_field label
  when 'Filter Selections By'
    select_element = page.find('#filter_by')
  when 'Status'
    select_element = page.find('#filter_status')
  when 'Errors'
    select_element = page.find('#filter_errors')
  end
  options_text = select_element.all("option").map do |option|
    option.text
  end
  (options.split(",").map{|o| o.strip } - options_text).should eq []
end

Then(/^I should see the second "(.*?)" dropdown list appear with default value "(.*?)"$/) do |label,options|
  case label
  when 'Status'
    cssname='#filter_status'
  when 'Errors'
    cssname='#filter_errors'
  end
  within("#{cssname}") do
    page.should have_content options
  end
end

Then(/^I should see the "(.*?)" dropdown menu$/) do |label|
  steps %{
    Then I should see the "#{label}" button
  }
end


