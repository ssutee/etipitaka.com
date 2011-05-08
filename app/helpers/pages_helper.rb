# encoding: utf-8

module PagesHelper
  def i_to_thai(i)
    i.to_s.gsub('0','๐').
      gsub('1','๑').
      gsub('2','๒').
      gsub('3','๓').
      gsub('4','๔').
      gsub('5','๕').
      gsub('6','๖').
      gsub('7','๗').
      gsub('8','๘').
      gsub('9','๙')
  end

  def title_link(index, volume, number)
    "#{i_to_thai(index)}. พระไตรปิฎก เล่มที่ #{i_to_thai(volume)} หน้าที่ #{i_to_thai(number)}"  
  end

  def search_excerpt(content, keywords)
    tmp = excerpt(content, keywords.split[0].gsub('+',' '), :radius => 50) 
    highlight(tmp, keywords.split.each { |keyword| keyword.gsub('+',' ') },
              :highlighter => '<span class="highlight_excerpt">\1</span>')
  end

  def page_detail(page)
    tmp = Book.where(:language => page.language, :volume => page.volume).first.title
    tmp += " ข้อที่ #{i_to_thai(page.items.first.number)}"
    page.items.count > 1 ? tmp + "-#{i_to_thai(page.items.last.number)}" : tmp
  end
end
