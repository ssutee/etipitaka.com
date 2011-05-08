require 'spec_helper'

describe PagesController do
  render_views
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

  describe "GET 'read'" do
    it "should be successful" do
      get 'read'
      response.should be_success
    end

    it "should have the right title" do
      get 'read'
      response.should have_selector('title', :content => "Read")
    end

  end

end
