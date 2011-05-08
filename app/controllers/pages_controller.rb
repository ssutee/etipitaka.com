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
    @books = Book.where(:language => language) unless language.nil? 
    @content = Page.content(language, volume, number)
    @keywords = params[:keywords]
  end

end
