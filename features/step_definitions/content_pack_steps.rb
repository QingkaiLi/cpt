Given(/I open the New Content Pack dialog$/) do
  steps %{
    Given I am logged in with "cas"
    When I go to the Content Pack Index page
    And I click the "New Content Pack" button
    Then I should see a pop up dialog named "New Content Pack"
  }
end

When(/^I go to the Content Pack Index page$/) do
  visit root_path
  @app = App.new
end


When(/^I type "(.*?)" as "(.*?)"$/) do |value, label|
  page.fill_in label, :with => value
end

When(/^I type (\d+) chars as "(.*?)"$/) do |length, label|
  str_to_fill = "a"*length.to_i
  page.fill_in label, :with => str_to_fill
end

Then(/^the content pack "(.*?)" length should be "(.*?)"$/) do |field, expected_length|
  case field
  when "name"
    page.find("a.content-pack-name").text.length.should eq expected_length.to_i
  when "description"
    page.find("td.content-pack-description").text.length.should eq expected_length.to_i
  end

end

When(/^I select "(.*?)" as "(.*?)"$/) do |type, label|
  page.select type, :from => label
end

And(/^I choose "(.*?)" as "(.*?)"$/) do |radio, lable|
  page.choose radio
end

When(/^I click the column header "(.*?)"$/) do |name|
  sorting_column_header = page.all("table#content_packs_table thead th[class^=sorting]")

  case name.downcase
  when "name"
    puts "Click Name to sort!"
    sorting_column_header[0].click
  when "last edited date"
    puts "Click Last Edited By to sort!"
    sorting_column_header[2].click
  when "type"
    puts "Click Type to sort!"
    sorting_column_header[3].click
  when "status"
    puts "Click Status to sort!"
    sorting_column_header[4].click
  else
    puts "Click CreatedBy to sort!"
    sorting_column_header[5].click
  end

end

Then(/^I should see the <required> <input> with <label>, <name> and <placeholder> within the "(.*?)" dialog$/) do |name,table|
#["required", "input", "label", "name", "placeholder"]
# ["true", "input", "Name", "name", "content name"]
# ["false", "textarea", "Description", "description", "description"]
  inputs =  table.raw[1 .. table.raw.size]
 case name
   when 'New Selection'
    cssname = '#new_selection_dialog'
   when 'New Content Pack'
    cssname = "#new_content_packs_dialog"
   when 'New Topic'
    cssname = "#new_topic_dialog"
   when 'Edit Topic Settings'
     cssname = '#edit_topic_dialog'
   when 'Edit Selection Settings'
     cssname = '#edit_selection_dialog'
   else
    # Edit Content Pack Settings
    cssname = "#edit_content_packs_dialog"
  end

  inputs.each do |input|
    within("#{cssname}") do
      label = page.find('label', text: input[2])
      begin
        label.find :xpath, './/attr[@title="required"]'
        required = "true"
      rescue
        required = "false"
      end

      ele = page.find_field input[2] #find input by label
      input[0].should eq required
      input[1].should eq ele.tag_name
      input[3].should eq ele['name']
      input[4].should eq ele['placeholder']
    end
  end
end

Then(/^I should see the <required> select with <label>, <name> and <options> within the dialog$/) do |selects_table|
  selects = selects_table.raw[1 .. selects_table.raw.size]
  selects.each do | select |
    label = page.find('label', text: select[1])
    begin
      label.find :xpath, './/attr[@title="required"]'
      required = "true"
    rescue
      required = "false"
    end
    ele = page.find_field select[1]
    select[0].should eq required
    select[2].should eq ele['name']
    options = ele.all("option").map do | option |
      option.text
    end
    select[3].should eq options.join ','
  end

end

Then(/^I should see the <buttons> within the "(.*?)" dialog$/) do |name,buttons_table|
  buttons = buttons_table.raw[1 .. buttons_table.raw.size]
  case name
  when 'New Selection'
    cssname = '#new_selection_dialog .actions'
  when 'New Content Pack'
    cssname = "#new_content_packs_dialog .actions"
  when 'Edit Topic Settings'
    cssname = "#edit_topic_dialog .actions"
  when 'Edit Selection Settings'
    cssname = "#edit_selection_dialog .actions"
  else
    # Edit Content Pack Settings
    cssname = "#edit_content_packs_dialog .actions"
  end

  buttons.each do |button|
    within("#{cssname}") do
      page.should have_button button[0]
    end
  end
end

And(/^I should see a pop up "(.*?)" dialog with "(.*?)" button$/) do |dialog, button|
  if dialog =='confirm_delete'
    page.find("#content_packs_delete_confirm").should have_button('Yes')
  end
end

And(/^I should not see a pop up "(.*?)" dialog$/) do |dialog|
  if dialog == 'confirm_delete'
    page.should_not have_xpath("//div[@id='content_packs_delete_confirm']")
  end
end

Then(/^I check the edit items for following (.*?) content packs$/) do |isempty, table|
 # table title for non-empty one: ["name","span.content-pack-type", "description"]
 # table title for empty one:["name","Type", "description"]"
 # table row: ["content pack one","Reading Assistance","This is content pack one"]
   contentpacks =  table.raw[1 .. table.raw.size]
   columns = table.column_names
   contentpacks.each do |contentpacks|
   steps %{
     When I click the "Edit" icon for "content pack" with name "#{contentpacks[0]}"
     }
   within("#edit_content_packs_dialog") do
      contentpacks[0].should eq (page.find_field columns[0])['value']
      if isempty=='non-empty'
        contentpacks[1].should eq (page.find columns[1]).text
      else
        contentpacks[1].should eq (page.find_field columns[1]).find(:xpath, 'option[@selected="selected"]').text
      end
      contentpacks[2].should eq (page.find_field columns[2]).text
      steps %{
        And I click the "Cancel" button
      }
   end
  end
end

Then(/^I should see the following columns on (.*?):$/) do |tablename, expected_columns|
  # The column names are under th>div except description.
  # Thanks to Webdriver. text method will include child node text.
  if tablename == 'content_table'
    columns = [['columns']] + page.all('table#content_packs_table thead th').map do |column_name|
      [column_name.text]
    end
  else
    columns = [['columns']]+ @app.topic_page.table_heads.map do |column|
      [column.text]
    end
 end
 expected_columns.diff!(columns)
end

Then(/^I should (not\s+)?see the following content packs?:$/) do |negation, expected_content_packs|
  within("table#content_packs_table") do
    content_packs = [['name']] + page.all('.content-pack-name').map do |content_pack_name|
      [content_pack_name.text]
    end
    if negation
      (expected_content_packs.rows & content_packs).empty?.should be_true
    else
      expected_content_packs.diff!(content_packs)
    end
  end
end

Then(/^I should see the "(.*?)" content pack created:$/) do |content_pack_name, expected_cp_table |
   within("table#content_packs_table") do
    # name, description, type, status, created_by
    content_pack_header = [['name', 'description', 'type', 'status', 'created_by']]

    # find the tr node of the entry
    content_pack_name_ele = page.find "a", :text=> content_pack_name
    entry_ele = content_pack_name_ele.find :xpath, "../.."

    # get the text values
    description = entry_ele.find("td.content-pack-description").text
    type = entry_ele.find("td.content-pack-type").text
    status = entry_ele.find("td.content-pack-status").text
    created_by = entry_ele.find("td.content-pack-created-by").text

    # construct an array
    content_pack_body = [[content_pack_name, description, type, status, created_by]]
    final_array = content_pack_header + content_pack_body
    expected_cp_table.diff!(final_array)
  end
end

Then(/^the "(.*?)" label turns "(.*?)"$/) do |label, state|
  if state == "Red"
    page.find("div.field_with_errors>label", :text => label).native.css_value("color").should eq "rgba(255, 0, 0, 1)"
  end
end

Then(/^I should see the message "([^"]*?)" in the "(.*?)"$/) do |expected_message, area|
  within("##{area}") do
    page.should have_content expected_message
  end
end

Then(/^these content pack names should be truncated with "(.*?)"$/) do |arg1|
  steps %{
    Then the ".content-pack-name" elements should have css "text-overflow" whose value is "ellipsis"
 }
end

Then(/^the "(.*?)" elements should have css "(.*?)" whose value is "(.*?)"$/) do |elements, css_attribute_name, css_attribute_value|
  page.all(elements).each do |ele|
     ele.native.css_value(css_attribute_name).should eq css_attribute_value
  end
end

Then(/^I should (not\s+)?see the bottom info\.$/) do |negation|
  if negation
    @app.content_packs_page.should_not have_total
    @app.content_packs_page.should_not have_pagination
    @app.content_packs_page.should_not have_items_per_page_select
  else
    @app.content_packs_page.should have_total
    @app.content_packs_page.total.text.should eq "Total: 3"

    @app.content_packs_page.should have_pagination

    @app.content_packs_page.should have_items_per_page_select
    @app.content_packs_page.items_per_page_label.text.should have_content "Item Per Page"
    option_text = []
    option_value = []
    @app.content_packs_page.items_per_page_options.each do |option|
      option_text << option.text
      option_value << option.value.to_i
      if option.text == "Show All"
        option.value.should eq "-1"
      else
        option.text.should eq option.value
      end
      if option.text == "10"
        option["selected"].should eq "true"
      end
    end
    [10, 30, 50, 100, -1].should eq option_value
    ["10", "30", "50", "100", "Show All"].should eq option_text
  end
end

Then(/^I should see "(.*?)" and (\d+) page number in the bottom$/) do |total_num, page_num|
    @app.content_packs_page.total.text.should eq total_num
    @app.content_packs_page.pagination_number.size.should eq page_num.to_i
end

Then(/^the current page number is (\d+)$/) do | number |
  @app.content_packs_page.pagination_current_number.text.should eq number.to_s
end

When(/^I click "(.*?)"$/) do |page|
  if page == "next page"
    @app.content_packs_page.pagination_next.click
  elsif page == "previous page"
    @app.content_packs_page.pagination_previous.click
  else
    @app.content_packs_page.pagination_number.select {|ele| ele.text == page }.first.click
  end
end

Then (/^the "(.*?)" link is inactive$/) do |link|
  if link == "next page"
    @app.content_packs_page.pagination_next["class"].should have_content "paginate_button_disabled"
  else link == "previous page"
    @app.content_packs_page.pagination_previous["class"].should have_content "paginate_button_disabled"
  end
end

Then(/^I should see (\d+) content pack records in current page$/) do |number|
  @app.content_packs_page.content_pack_records.size.should eq number.to_i
end

When(/^I hover over the content pack name (.*?)$/) do |name|
  page.find('a.content-pack-name', :text => name).hover
end

When(/^I hover over the (edit|delete?) icon for content pack (.*?)$/) do |icon, name|
  if icon == "edit"
     cssname = "icon-edit"
  elsif icon == "delete"
     cssname = "icon-delete"
  end
  content_ele = @app.content_packs_page.get_contentpack_column_ele_by_name name
  within content_ele do
    content_ele.find("a.#{cssname}").hover
  end
end

Then(/^I should see the title of (?:delete icon:|edit icon:|content pack name) (.*?)$/) do | name |
  page.should have_selector('div.qtip')
  tip_shown = page.all("div.qtip").each do | tip |
    if tip["aria-hidden"] == "false"
      tip.text.should eq name
    end
  end
end
