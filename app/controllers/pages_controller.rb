# encoding: utf-8

class PagesController < ApplicationController
  def search
    @title = 'Search'
    if !params[:search].nil? and params[:search].has_key?(:keywords)
      keywords = params[:search][:keywords]
      language = params[:search][:language]
    end

    if !keywords.blank? and params[:page].nil?
      session[:keywords] = keywords
      session[:language] = params[:search][:language]
      pages = Page.search_all(language, keywords) 
      @pages = pages.paginate(:page => params[:page], :per_page => 10)
      @current_page = 1
      @per_page = 10
      @keywords = keywords
      @language = language
    elsif keywords.nil? and !params[:page].nil? and !session[:keywords].nil?
      pages = Page.search_all(session[:language], session[:keywords]) 
      @pages = pages.paginate(:page => params[:page], :per_page => 10)
      @current_page = params[:page]
      @per_page = 10
      @keywords = session[:keywords]
      @language = session[:language]
    end
  end

  def read
    @title = 'Read'

    language = params[:language]
    volume = params[:volume]
    number = params[:number]

    if !params[:read].nil? and params[:read].has_key?(:page_number)
      language = session[:cur_language]
      volume = session[:cur_volume]
      number = params[:read][:page_number]
    end

    if !params[:read].nil? and params[:read].has_key?(:item_number)
      language = session[:cur_language]
      volume = session[:cur_volume]
      items = Item.find_by(language, volume, params[:read][:item_number])
      if items.count == 1
        number = items.first.page.number
      end
    end

    session[:cur_language] = language
    session[:cur_volume] = volume

    @language = language
    @volume = volume
    @max_number = Page.max(language,volume) if !language.nil? and !volume.nil? 

    @books = Book.where(:language => language) unless language.nil? 
    @content = Page.content(language, volume, number) unless number.nil?
    
    if (number.to_i == 0 or @content.nil?) and (items.nil? or items.empty?)
      @content = "พระไตรปิฎกเล่มที่ #{i_to_thai(volume)} มีทั้งหมด\n"
      @content += "    #{i_to_thai(Page.max(language,volume))} หน้า"
      @content += " #{i_to_thai(Item.max(language,volume))} ข้อ\n"
      @number = 0
    elsif !items.nil? and !items.empty? and @content.nil?
      @content = "พบข้อที่ #{i_to_thai(items.first.number)}"
      @content += " ทั้งหมด #{i_to_thai(items.count)} แห่ง\n"
      @items = items
      @content += render_to_string :partial => "pages/link_to_pages" 
    else
      @number = number
      @keywords = params[:keywords]
    end

    if !language.nil? and !volume.nil?
      @volume = volume
      if language == 'thai'
        tmp = 'ฉบับบาลีสยามรัฐ (ภาษาไทย)'
      elsif language == 'pali'
        tmp = 'ฉบับบาลีสยามรัฐ (ภาษาบาลี)'
      end
      @title1 = "พระไตรปิฎก #{tmp} เล่มที่ #{i_to_thai(volume)}"
      @title2 = Book.where(:language => language, :volume => volume).first.title
      p = Page.where(:language => language, :volume => volume, :number => number).first
      number = 0 if p.nil?
      @page_number_info = 'หน้าที่ ' + i_to_thai(number) unless number.to_i == 0
      @page_number_info += '/'+i_to_thai(@max_number) unless @page_number_info.nil?
      @item_number_info = 'ข้อที่ ' + i_to_thai(p.items.first.number) unless number.to_i == 0
      if number.to_i != 0 and p.items.count > 1
        @item_number_info += '-' + i_to_thai(p.items.last.number)
      end
    end
  end

  def compare
    @title = "Compare"
    @volume = params[:volume]
    @languages = [ params[:lang1], params[:lang2] ]
    
    params[:p2] ||= find_matched_page(params[:lang1],
                                      params[:lang2],
                                      params[:volume],
                                      params[:p1])

    @pages = [ params[:p1], params[:p2] ]
    @titles1, @titles2, @contents, @max_numbers = [], [], [], []
    @page_number_info, @item_number_info = [], []

    i = 0
    for lang in @languages
      if lang == 'thai'
        tmp = 'ฉบับบาลีสยามรัฐ (ภาษาไทย)'
      elsif lang == 'pali'
        tmp = 'ฉบับบาลีสยามรัฐ (ภาษาบาลี)'
      end
      @titles1 << "พระไตรปิฎก #{tmp} เล่มที่ #{i_to_thai(@volume)}"
      @titles2 << Book.where(:language => lang, :volume => @volume).first.title
      @contents << Page.content(lang, @volume, @pages[i]) 
      @max_numbers << Page.max(lang, @volume)  
      p = Page.where(:language => lang, :volume => @volume, :number => @pages[i]).first

      tmp = 'หน้าที่ ' + i_to_thai(@pages[i]) 
      tmp += '/'+i_to_thai(@max_numbers[i]) 
      @page_number_info << tmp
      
      tmp = 'ข้อที่ ' + i_to_thai(p.items.first.number) 
      if p.items.count > 1
        tmp += '-' + i_to_thai(p.items.last.number)
      end
      @item_number_info << tmp
      i += 1
    end
  end

  def test
  end

  private

    def find_matched_page(lang1, lang2, volume, page)
      item = Page.where(:language => lang1, 
                     :volume => volume, 
                     :number => page).first.items.first

      page_ids = %(SELECT id FROM pages WHERE language = :lang2 AND volume = :volume) 

      tmp = Item.where("page_id IN (#{page_ids}) AND"+ 
                       " begin = 't' AND section = :section AND"+
                       " number = :number", 
                       { :lang2 => lang2, 
                         :volume => volume, 
                         :section => item.section, 
                         :number => item.number }).first
      tmp.nil? ? 1 : tmp.page.number
    end
end
