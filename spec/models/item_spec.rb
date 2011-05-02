require 'spec_helper'

describe Item do
  before(:each) do
    @page = Factory(:page)
    @attr = { :begin => true, :number => 1, :section => 0 } 
  end
  it "should create a new instance given valid attributes" do
    @page.items.create!(@attr)
  end

  it "should not create a new instance given invalid attributes" do
    item = @page.items.build
    item.should_not be_valid
  end
end
