require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user) 
  end
  describe "bookmarks associations" do
    it "should have a bookmarks attribute" do
      @user.should respond_to(:bookmarks) 
    end
  end
end
