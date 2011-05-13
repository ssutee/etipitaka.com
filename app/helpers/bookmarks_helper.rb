# encoding: utf-8
#
include PagesHelper

module BookmarksHelper
  def bookmark_header(page_id, item_number)
    page = Page.find(page_id)
    header = "พระไตรปิฎกเล่มที่ #{i_to_thai page.volume}"+
             " หน้าที่ #{i_to_thai page.number}"+
             " ข้อที่ #{i_to_thai item_number}"
  end
end
