class ContentPacksPage < SitePrism::Page
  element :bottom, "div.bottom"
  element :total, "div#content_packs_table_info"

  element :pagination, "div#content_packs_table_paginate"
  element :pagination_previous, "a#content_packs_table_previous"
  element :pagination_next, "a#content_packs_table_next"
  elements :pagination_number, "div#content_packs_table_paginate>span>a"
  element :pagination_current_number, "div#content_packs_table_paginate a.paginate_active"

  element :items_per_page_label, "div#content_packs_table_length>label"
  element :items_per_page_select, "select[name='content_packs_table_length']"
  elements :items_per_page_options, "select[name='content_packs_table_length']>option"

  elements :content_pack_records, "table#content_packs_table>tbody>tr"

  element :current_user_name, "header.navbar span"


  def get_contentpack_column_ele_by_name name
    arr = content_pack_records.select do |column|
      column.text.include? name
    end
    arr.first
  end

  def get_contentpack_attr_by_title title, attr
    ele = get_contentpack_column_ele_by_name title
    if (attr == 'Last Edited Date')
      ele.find("td.content-pack-last-update-date").text
    elsif (attr == 'Created By')
      ele.find("td.content-pack-created-by").text
    end
  end

  def get_current_user_name
    current_user_name.text
  end

end

