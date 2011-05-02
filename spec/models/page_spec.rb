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
end
