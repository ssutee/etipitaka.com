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
      end
      @title1 = "พระไตรปิฎก #{tmp} เล่มที่ #{i_to_thai(volume)}"
      @title2 = Book.where(:language => language, :volume => volume).first.title
      p = Page.where(:language => language, :volume => volume, :number => number).first
      number = 0 if p.nil?
      @page_number_info = 'หน้าที่ ' + i_to_thai(number) unless number.to_i == 0
      @item_number_info = 'ข้อที่ ' + i_to_thai(p.items.first.number) unless number.to_i == 0
      if number.to_i != 0 and p.items.count > 1
        @item_number_info += '-' + i_to_thai(p.items.last.number)
      end
    end
  end
end
