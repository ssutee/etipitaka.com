# encoding:utf-8

require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    Factory(:page)
    Factory(:item)
  end

  describe "GET 'search'" do
    it "should be successful" do
      get 'search'
      response.should be_success
    end

    it "should have the right title" do
      get 'search'
      response.should have_selector('title', :content => "Search")
    end
  end

  describe "POST 'search'" do
    it "should display a notificaton if no results" do
      post 'search', :search => { :language => 'thai', :keywords => 'abcd' }
      flash[:notice].should =~ /ไม่พบคำว่า/i
    end

    it "should display a notification if input is blank" do
      post 'search', :search => { :language => 'thai', :keywords => ' ' }
      flash[:notice].should =~ /กรุณาป้อนคำค้นหา/i
    end
  end

  describe "GET 'read'" do
    it "should redirect to first page of Thai" do
      get 'read'
      response.should redirect_to read_path(:language => 'thai', :volume => 1, :number => 0)
    end

  end

end
