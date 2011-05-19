#encoding: utf-8

require 'spec_helper'

describe BookmarksController do
  describe "signed user" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
    end

    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "non signed in user" do
    it "should redirect to search page" do
      get 'index'
      response.should redirect_to search_path
    end

    it "should flash an error message" do
      get 'index'
      flash[:error].should =~ /กรุณาเข้าสู่ระบบ/i
    end
  end
end
