module PaginationHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
  protected
    def windowed_page_numbers
      page_number = 10
      before_current = 4
      after_current = page_number - before_current - 1
      #:inner_window - how many links are shown before the current page (default: 4)
      window_from = current_page - before_current
      window_to = current_page + after_current

      # adjust lower or upper limit if other is out of bounds
      if window_to > total_pages
        window_from = total_pages - page_number + 1
        window_to = total_pages
      end
      if window_from < 1
        window_to = page_number
        window_from = 1
        window_to = total_pages if window_to > total_pages
      end
      # these are always visible
      (window_from..window_to).to_a
    end
  end
end
