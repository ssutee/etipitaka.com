require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user) 
    @admin = Factory(:user, :admin => true, :email => 'admin@test.com')
  end
  describe "bookmarks associations" do
    it "should have a bookmarks attribute" do
      @user.should respond_to(:bookmarks) 
    end
  end

  describe "admin testing" do
    it "should have a admin? method" do
      @user.should respond_to(:admin?)
    end

    it "should return a right value" do
      @user.admin?.should be_false
      @admin.admin?.should be_true
    end
  end
end
