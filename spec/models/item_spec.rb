require 'spec_helper'

describe Item do
  before(:each) do
    @page = Factory(:page)
    @attr = { :begin => true, :number => 1, :section => 1 } 
  end
  it "should create a new instance given valid attributes" do
    @page.items.create!(@attr)
  end

  it "should not create a new instance given invalid attributes" do
    item = @page.items.build
    item.should_not be_valid
  end

  it "should have a page attribute" do
    item = @page.items.create(@attr)
    item.should respond_to(:page)
  end

  it "should have the right associated page" do
    item = @page.items.create(@attr)
    item.page.should == @page
  end

  it "should have a 'total' class attribute" do
    Item.should respond_to(:total)
  end

  it "should have a 'content' class attribute" do
    Item.should respond_to(:content)
  end
end
