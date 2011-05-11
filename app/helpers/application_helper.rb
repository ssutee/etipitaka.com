module ApplicationHelper
  def title
    base_title = 'E-Tipitaka'
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end
end

include PagesHelper

class MyLinkRenderer < WillPaginate::LinkRenderer
  def page_link(page, text, attributes = {})
    @template.link_to i_to_thai(text), url_for(page), attributes
  end
  
  def page_span(page, text, attributes = {})
    @template.content_tag :span, i_to_thai(text), attributes
  end
end

