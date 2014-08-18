Then(/^I should see the "(.*?)" link$/) do |link_text|
  case link_text
  when "< BACK TO CONTENT PACKS"
    @app.topic_page.has_backto_contentpack_link?
  end
end

When(/^I login and go to the topic page of content pack "(.*?)"$/) do |content|
  steps %{
    And I am logged in with "CAS"
    When I go to the Content Pack Index page
    And I click the content pack "#{content}"
  }
end

Then(/^I should (not\s+)?see the following (\d+) selections?:$/) do |negation, n, expected_selections|
  within(@app.topic_page.topic_table) do
    selections = [["Title", "Status", "Last Edited By"]]
    @app.topic_page.table_selections.map do |selection|
      selections << [selection.find('div.col-title').text, selection.find('div.col-status').text, selection.find('div.col-update-by').text]
    end
    if negation
      (expected_selections.rows & selections).empty?.should be_true
    else
      expected_selections.diff!(selections)
    end
  end
end

Then(/^I should see "Selections Per Page" dropdown menu with options: 10, 30, 50, 100, Show All and default is 30 in the right bottom below the topics table$/) do
  @app.topic_page.should have_selections_per_page_select
  @app.topic_page.selections_per_page_label.text.should have_content "Selections Per Page"
  option_text = []
  option_value = []
  @app.topic_page.items_per_page_options.each do |option|
    option_text << option.text
    option_value << option.value.to_i
    if option.text == "Show All"
      option.value.should eq "-1"
    else
      option.text.should eq option.value
    end
    if option.text == "30"
      option["selected"].should eq "true"
    end
  end
  [10, 30, 50, 100, -1].should eq option_value
  ["10", "30", "50", "100", "Show All"].should eq option_text
end

Then(/^I should see the following (\d+) topics?:$/) do |n, expected_table|
  @app.topic_page.topic_records.size.should eq n.to_i
  result_table =  [["Title", "Grade Level"]]
  @app.topic_page.topic_records.each do |topic|
    result_table << [topic.find('.col-title').text, topic.find('.col-grade-level').text]
  end
  expected_table.diff! result_table
end

Then(/^the topic "(.*?)" (length|value?) should be "(.*?)"$/) do |field, attr, expected_attr|
  case field
  when "Name"
    ele = @app.topic_page.topic_records[0].find('.col-title')
  when "Grade Level"
    ele = @app.topic_page.topic_records[0].find('.col-grade-level')
  end
  if attr == "length"
    # cumulative 4 is for the end topic string length " (0)"
    ele.text.length.should eq expected_attr.to_i+4
  elsif attr == "value"
    ele.text.should eq expected_attr
  end
end

Then(/^I click the arrow icon of topic (.*?)$/) do |content_name|
    ele = @app.topic_page.get_topic_title_column_ele_by_title content_name
   within ele do
     @app.topic_page.topic_arrow_down_icon.click
   end
end

Then(/^I should see the notice text "(.*?)"$/) do | message |
   sleep 2.to_i
   @app.topic_page.notice_text.text.should eq message
end