# encoding: utf-8

class UsersController < ApplicationController
  def index
    if !signed_in?
      flash[:error] = 'กรุณาเข้าสู่ระบบก่อนจึงจะสามารถดูรายชื่อผู้ใช้คนอื่นได้'
      redirect_to search_path 
    end
    @title = "Users"
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @title = "#{@user.user_name}"
    @bookmarks = @user.bookmarks.paginate(:page => params[:page], :per_page => 10)
  end
end
