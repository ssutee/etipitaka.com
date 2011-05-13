class BookmarksController < ApplicationController
  def index
    @title = "Bookmark"
  end

  def create
    if signed_in?
      current_user.bookmarks.create!(params[:bookmark])
    else
      flash.now[:notice] = "Please sign in to create a new bookmark"
    end
    redirect_to params[:refer]
  end

  def destroy
    if signed_in?
      bookmark = Bookmark.find(params[:id])  
      if current_user.id == bookmark.user.id
        bookmark.delete
      else
        flash.now[:notice] = "You don't have permission to delete this bookmark"
      end
    else
      flash.now[:notice] = "Please sign in to create a new bookmark"
    end
    redirect_to bookmarks_path
  end

  def edit
  end

end
