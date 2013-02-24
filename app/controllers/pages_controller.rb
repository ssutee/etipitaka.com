# encoding: utf-8

class PagesController < ApplicationController

  def search
    @title = 'Search'
    if !params[:search].nil? and params[:search].has_key?(:keywords)
      @keywords = params[:search][:keywords]
      @language = params[:search][:language]
    end

    if !@keywords.blank? and params[:page].nil?
      session[:keywords] = @keywords
      session[:language] = params[:search][:language]
      pages = Page.search_all(@language, @keywords) 
      @category = count_category(pages) 
      @count = pages.count
      @pages = pages.paginate(:page => params[:page], :per_page => 10)
      @current_page = 1
      @per_page = 10
    elsif @keywords.nil? and !params[:page].nil? and !session[:keywords].nil?
      pages = Page.search_all(session[:language], session[:keywords]) 
      @category = count_category(pages) 
      @count = pages.count
      @pages = pages.paginate(:page => params[:page], :per_page => 10)
      @current_page = params[:page]
      @per_page = 10
      @keywords = session[:keywords]
      @language = session[:language]
    end

    if !@keywords.nil? and @keywords.blank?
      flash.now[:notice] = 'กรุณาป้อนคำค้นหา'
    elsif !@keywords.blank? and (@pages.nil? or @pages.empty?)
      if @language == 'thai'
        tmp = 'ไทย (บาลีสยามรัฐ)'
      elsif @language == 'pali'
        tmp = 'บาลี (บาลีสยามรัฐ)'
      end
      flash.now[:notice] = "ไม่พบคำว่า \"#{@keywords}\" ในพระไตรปิฎก ภาษา#{tmp}"
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
      number = items.first.page.number if items.count == 1
    end

    if language.nil? or volume.nil?
      redirect_to read_path(:language => 'thai', :volume => 1, :number => 0)
      return
    end

    if number.nil?
      redirect_to read_path(:language => language, :volume => volume, :number => 0)
      return
    end

    session[:cur_language] = language
    session[:cur_volume] = volume
    
    @books = Book.where(:language => language)
    @language = language
    @volume = volume
    @number = number
    @keywords = params[:keywords]
    
    @max_number = find_max_page(language, volume)
    @max_item = find_max_item(language, volume)
    
    @all_pages = create_all_pages(language, volume, @max_number, @max_item)    
    @items_map = create_items_map(language, volume)
    @title1, @title2 = create_titles(language, volume)

    if signed_in?
      @bookmark = Bookmark.new
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
    @max_numbers, @max_items = [], []
    @titles, @all_pages, @items_maps = [], [], []

    i = 0
    for language in @languages      
      @max_numbers[i] = find_max_page(language, @volume)
      @max_items[i] = find_max_item(language, @volume)
      @titles[i] = create_titles(language, @volume)
      @all_pages[i] = create_all_pages(language, @volume, @max_numbers[i], @max_items[i])
      @items_maps[i] = create_items_map(language, @volume)      
      i += 1
    end    
  end

  private
    def transform_hash(original, options={}, &block)
      original.inject({}){|result, (key,value)|
        value = if (options[:deep] && Hash === value) 
                  transform_hash(value, options, &block)
                else 
                  value
                end
        block.call(result,key,value)
        result
      }
    end  
    
    def create_titles(language, volume)      
      if language == 'thai'
        book_title = 'ภาษาไทย (ฉบับหลวง)'
      elsif language == 'pali'
        book_title = 'ภาษาบาลี (ฉบับสยามรัฐ)'
      end
      ["พระไตรปิฎก #{book_title} เล่มที่ #{i_to_thai(volume)}",
        Book.where(:language => language, :volume => volume).first.title]
    end
  
    def create_items_map(language, volume)
      Rails.cache.fetch("/#{language}/#{volume}/items_map") do
        items_map = {}
        Page.all_pages(language, volume).each do |page|
          item_number = page.items.first.number.to_i
          if !items_map.has_key?(item_number)
            items_map[item_number] = [page.number.to_i]
          elsif
            items_map[item_number].concat([page.number.to_i])
          end
        end  
        transform_hash(items_map) {|hash, key, value|       
          acc = [value[0]]
          value.each_cons(2) {|x,y| acc << y if x != y-1}
          hash[key] = acc
        }              
      end
    end

    def create_all_pages(language, volume, max_page, max_item)
      pages = Rails.cache.fetch("/#{language}/#{volume}") do
        Page.all_pages(language, volume).map do |page|
          page_number_info = 'หน้าที่ ' + i_to_thai(page.number) unless page.number.to_i == 0
          page_number_info += '/'+i_to_thai(max_page) unless page_number_info.nil?      
          item_number_info = ''
          item_number_info += 'ข้อที่ ' + i_to_thai(page.items.first.number) unless page.number.to_i == 0
          if page.number.to_i != 0 and page.items.count > 1
            item_number_info += '-' + i_to_thai(page.items.last.number)
          end      
          [page.content, page_number_info, item_number_info, 
            i_to_thai(page.number), page.id, page.items.first.number]
        end      
      end

      first_page = "พระไตรปิฎกเล่มที่ #{i_to_thai(volume)} มีทั้งหมด\n"
      first_page += "    #{i_to_thai(max_page)} หน้า"
      first_page += " #{i_to_thai(max_item)} ข้อ\n"    

      all_pages = [[first_page, '', '', '', 0, 0]]
      all_pages.concat(pages)
    end

    def find_max_page(language, volume)
      Rails.cache.fetch("/#{language}/#{volume}/max_page"){Page.max(language,volume)}
    end
    
    def find_max_item(language, volume)
      Rails.cache.fetch("/#{language}/#{volume}/max_item"){Item.max(language,volume)}
    end

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

    def count_category(pages)
      count = {}
      pages.each do |page|
        if page.volume.to_i <= 8
          count[:v] = count[:v].to_i + 1
        elsif page.volume.to_i <= 33
          count[:s] = count[:s].to_i + 1
        else
          count[:a] = count[:a].to_i + 1
        end
      end
      count
    end
end
