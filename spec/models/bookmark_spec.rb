require 'spec_helper'

describe Bookmark do
  before (:each) do
    @user = Factory(:user)
    @page = Factory(:page)
    @attr = { :note => 'test', :page_id => @page.id }
  end

  it "should create a new intance given valid attributes" do
    @user.bookmarks.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @bookmark = @user.bookmarks.create!(@attr)
    end

    it "should have a user attribute" do
      @bookmark.should respond_to(:user)
    end

    it "should have the right associated user" do
      @bookmark.user_id.should == @user.id
      @bookmark.user.should == @user
    end
  end

  describe "page association" do
    before(:each) do
      @bookmark = @user.bookmarks.create!(@attr)
    end

    it "should have a page attribute" do
      @bookmark.should respond_to(:page)    
    end

    it "should have the right associated page" do
      @bookmark.page_id.should == @page.id
      @bookmark.page.should == @page
    end
  end

end
