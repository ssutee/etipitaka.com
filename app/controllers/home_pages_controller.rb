# encoding: utf-8
class HomePagesController < ApplicationController
  layout "main"

  before_filter :create_links_and_posts

  def home
    @title = "Home"
    @topic = "หน้าแรก"
  end

  def news
    @title = "News"
    @topic = "ข่าวทั้งหมด"
    @all_posts = Post.all
  end

  def recent_news
    @title = "Recent news"
    @topic = "ข่าวล่าสุด"
    @all_posts = Post.where(:id => params[:id])
  end

  def background
    @title = "Background"
    @topic = "ประวัติความเป็นมา"
  end

  def howto
    @doc = params[:doc]
    if params[:doc] == 'android'
      @title = "Howto - Android"
    elsif params[:doc] == 'ipad'
      @title = "Howto - iPad"
    elsif params[:doc] == 'iphone'
      @title = "Howto - iPhone"
    else
      @title = "Howto"
    end
    @topic = "วิธีใช้โปรแกรม"
  end

  def download
    @title = "Download"
    @topic = "ดาวน์โหลด"
  end
  
  private
    def create_links_and_posts
      @links = Link.all
      @posts = Post.all[(0..5)]
    end
end
