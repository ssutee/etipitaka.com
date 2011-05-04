module ApplicationHelper
  def title
    base_title = 'E-Tipitaka'
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end
end
