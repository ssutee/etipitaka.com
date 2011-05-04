require 'spec_helper'

describe Page do

  before(:each) do
    @attr = { :language => 'thai', :volume => 1, :number => 1 , 
              :content => 'foo bar'}
  end

  it "should create a new instance given valid attribute" do
    Page.create!(@attr)
  end

  it "should not create a new instance given invalid attribute" do
    page = Page.new
    page.should_not be_valid
  end

  it "should have an items attribute" do
    page = Page.create(@attr)
    page.should respond_to(:items)
  end

  it "should have a 'total' class attribute" do
    Page.should respond_to(:total)
  end

  it "should have a 'content' class attribute" do
    Page.should respond_to(:content)
  end

  it "should have a 'search' class attribute" do
    Page.should respond_to(:search)
  end
  
end
