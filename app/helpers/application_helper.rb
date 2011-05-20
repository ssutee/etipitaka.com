module ApplicationHelper
  def title
    base_title = 'E-Tipitaka'
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end
end

include PagesHelper

class MyLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  protected
    
    def page_number(page)
      unless page == current_page
        link(i_to_thai(page), page, :rel => rel_value(page))
      else
        tag(:em, i_to_thai(page), :class => "current")
      end
    end
end

