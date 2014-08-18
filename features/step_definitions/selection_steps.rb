When(/^I click the content pack "(.*?)"$/) do |content|
  page.find(:xpath, "//a[@class=\'content-pack-name\' and @oldtitle=\'#{content}\']").click
end

Then(/^I should see the "(.*?)" selection created:$/) do |selection_name, expected_selection_table |
  within("ul#topics_list") do
  # title, status, last_edited_date, last_edited_by, errors
  selection_header = [['title', 'status', 'last_edited_by', 'errors']]

  title = selection_name;

  # get the text values
  status = @app.topic_page.selection_status.text
  last_edited_by = @app.topic_page.selection_last_edited_by.text
  errors = @app.topic_page.selection_errors.text

  # construct an array
  selection_body = [[title, status, last_edited_by, errors]]
  final_array = selection_header + selection_body
  expected_selection_table.diff!(final_array)
end
end

Then(/^the selection "(.*?)" length should be "(.*?)"$/) do |field,expected_length|
  case field
  when "title"
    page.find("input#selection_title").value.length.should eq expected_length.to_i
  when "description"
    page.find("textarea#selection_description").value.length.should eq expected_length.to_i
  when "author"
    page.find("input#selection_author").value.length.should eq expected_length.to_i
  when "illustrator"
    page.find("input#selection_illustrator").value.length.should eq expected_length.to_i
  when "publisher"
    page.find("input#selection_publisher").value.length.should eq expected_length.to_i
  when "introductory"
    page.find("textarea#selection_intro_text").value.length.should eq expected_length.to_i
  end
end

Then(/^I should (not\s+)?see the following (\d+) selections? listed in "(.*?)":$/) do |negation, n, topic, selections_table|
  topic_title_ele = @app.topic_page.get_topic_title_column_ele_by_title topic
  topic_ele = topic_title_ele.find(:xpath,"../../..")
  within topic_ele do
    all_selections = topic_ele.all("li.selection")
    result_table = [["Title", "Status", "Last Edited Date", "Last Edited By"]]
    all_selections.each do |selection|
      result_table << [selection.find(".col-title").text, selection.find(".col-status").text, selection.find(".col-update-at").text, selection.find(".col-update-by").text]
    end
    if negation
      (selections_table.rows & result_table).empty?.should be_true
    else
    all_selections.length.should eq n.to_i
    selections_table.diff! result_table
    end
  end
end


Then(/^I should see the radio "(.*?)" for "(.*?)" set by defult$/) do |radio, label|
 @app.topic_page.selection_internationally_no_raido['checked'].should eq "true"
end

When(/^I click the "(.*?)" icon for the (.*?) selection$/) do |edit_icon, index|
  case index
  when "just created"
   page.find("li.selection a.icon-edit").click
  when "third"
   page.all("li.selection a.icon-edit")[2].click
  when "just edited"
    ele = @app.topic_page.get_selection_ele_by_date Time.now.strftime("%m/%d/%Y")
    ele.find("a.icon-edit").click
  end

end

Then(/^I check the edit items for following selections/) do |table|
 # table title ["title", "grade_equivalent_level", "lexile_level", "guided_reading_level",
 #              "wcpm_target", "internationally", "description","author illustrator","publisher"]

 # table row: ["selectionAAA","12","NP", " D",
 #             "250","1","AA;AAAA"," Setven.La","Jafferson","Ching Lee"]
   selections =  table.raw[1 .. table.raw.size]
   columns = table.column_names
   selections.each do |selection|
   steps %{
     When I click the "Edit" icon for "selection" with name "#{selection[0]}"
  }


   within("#edit_selection_dialog") do
        selection[0].should eq (page.find_field columns[0])['value']
        selection[1].should eq (page.find_field columns[1]).find(:xpath, 'option[@selected="selected"]').text
        selection[2].should eq (page.find_field columns[2]).find(:xpath, 'option[@selected="selected"]').text
        selection[3].should eq (page.find_field columns[3]).find(:xpath, 'option[@selected="selected"]').text
        selection[4].should eq (page.find_field columns[4])['value']
        selection[5].should eq page.find(:xpath, '//input[@name="selection[internationally]" and @checked="checked"]')['value']
        selection[6].should eq (page.find_field columns[6]).text
        selection[7].should eq (page.find_field columns[7])['value']
        selection[8].should eq (page.find_field columns[8])['value']
        selection[9].should eq (page.find_field columns[9])['value']
      steps %{
        And I click the "Cancel" button
      }
   end
  end
end


Then(/^The "(.*?)" for "(.*?)" with name "(.*?)" should (not\s+)?be updated$/) do |field, obj, name, negation|
  obj_page = (obj == 'content pack')?'content_pack_page':'topic_page'
  if obj_page == 'topic_page'
    attr_value = @app.topic_page.get_selection_attr_by_title name, field
  else
    attr_value = @app.content_packs_page.get_contentpack_attr_by_title name, field
  end
  case field
  when "Last Edited Date"
    expect_value = Time.now.strftime("%m/%d/%Y")
  else
   # "Last Edited By"
   # "Created By"
    expect_value = @app.content_packs_page.get_current_user_name
  end
  if negation
    attr_value.should_not eq expect_value
  else
    attr_value.should eq expect_value
  end
end


