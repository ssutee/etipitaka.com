# encoding:utf-8

require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @user = Factory(:user) 
  end

  describe "non signed in user" do
    it "should redirect to search page" do
      get 'index'
      response.should redirect_to(search_path)
    end

    it "should flash an error message" do
      get 'index'
      flash[:error].should =~ /กรุณาเข้าสู่ระบบ/
    end
  end

  describe "signed in user" do
    before(:each) do
      sign_in @user
    end
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have a right title" do
      get 'index'
      response.should have_selector(:title, :content => 'Users')
    end

  end
end
