require File.dirname(__FILE__) + '/../spec_helper'

describe New do
  it "should be valid" do
    New.new.should be_valid
  end
end
