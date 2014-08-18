module PronunciationsHelper
  def per_page
    @per_page = request.params['per_page']
    if @per_page == nil
      @per_page = 30
    end
    @per_page.to_i
  end

  def sortable(title)
    @request_order = request.params['order']
    @order = @request_order == 'desc' ? 'asc' : 'desc'
    link_to title, params.merge(:order => @order, :page => 1), {:class => "sort-icon #{@order}"}
  end

  def clear_search
    attribute = request.params[:search]
    link_to "Clear Search", params.merge(:search => '', :page => 1), {:class => (attribute.nil? || attribute.empty? ? "link hide" : "link"), id: "clear_search"}
  end

  def clear_filter
    attribute = request.params[:filter]
    link_to "Clear Filter", params.merge(:filter => '', :page => 1), {:class => (attribute.nil? || attribute.empty? || attribute.to_i == -1 ? "link hide" : "link"), id: "clear_filter"}
  end

  def pronunciation_span(pronunciation)
    status_name = pronunciation.pronunciation_status.name
    class_name = status_name.gsub(/[ ]/,'-').downcase
    if status_name == 'Approved'
      content_tag(:span, '', :class =>"#{class_name} word-status" , :title => "Approved by #{pronunciation.user.name}")
    else
      content_tag(:span, '', :class =>"#{class_name} word-status" , :title => "#{status_name}")
    end
  end
end
