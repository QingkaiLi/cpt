class TopicPage < SitePrism::Page
  element :content_name, "span.content-title"
  element :content_edit_icon, "a.icon-edit"
  element :content_type, ".pure-u-1>h2>span"
  element :backto_contentpack_link, "header>a.link"

  element :new_topic_button, "#new_topic"
  element :new_selection_button, "#new_selection"
  element :new_topic_dialog, "#new_topic_dialog"
  element :topic_table, "#topics_list"

  elements :table_heads, "#topic_header>div"
  elements :table_selections, "#topics_list li.selection"
  elements :table_topics, "#topics_list li.topic-info"
  element :topic_arrow_down_icon, "div.col-title>i.icon-drop-down"

  element :total_selection, ""
  element :pagination, ""
  element :selections_per_page_label, "div#topics_table_length>label"
  element :selections_per_page_select, "select[name='topics_table_length']"
  elements :selections_per_page_options, "select[name='topics_table_length']>option"

  elements :topic_records, "#topics_list ul>li.topic-info"
  elements :topic_title_columns, "#topics_list div.col-title"
  elements :topic_title_names, "#topics_list div.co-title>span.col-name"

  element :selection_status, "li.selection div.col-status"
  element :selection_last_edited_by, "li.selection div.col-update-by"
  element :selection_errors, "li.selection div.col-errors"
  element :selection_internationally_no_raido, "#selection_internationally_false"

  element :move_copy_to_content_pack_select, "select#content_pack_id"
  elements :move_copy_to_content_pack_select_options, "select#content_pack_id>option"

  elements :all_selections, "#topics_list li.selection"
  
  element :notice_text, "#gritter-notice-wrapper p"


  def get_topic_title_column_ele_by_title title
    arr = topic_title_columns.select do |column|
      column.text.include? title
    end
    arr.first
  end

 def get_selection_ele_by_title title
   ele = all_selections.select do |column|
     column.find(".col-title").text.include? title
    end
    ele.first
 end

 def get_selection_attr_by_title title, attr
   ele = get_selection_ele_by_title title
   if (attr == 'Last Edited Date')
     ele.find(".col-update-at").text
   elsif (attr == 'Last Edited By')
     ele.find(".col-update-by").text
   end
 end

 def get_selection_ele_by_date attr
   ele = all_selections.select do |column|
     column.find(".col-update-at").text.include? attr
   end
   ele.first
end
end
