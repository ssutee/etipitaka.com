# encoding: utf-8
class HomePagesController < ApplicationController
  layout "main"

  before_filter :create_links_and_posts

  def home
    @title = "Home"
    @topic = "โปรแกรม E-Tipitaka"
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

  private
    def create_links_and_posts
      @links = Link.all
      @posts = Post.all[(0..5)]
    end
end
