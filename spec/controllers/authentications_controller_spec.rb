require File.dirname(__FILE__) + '/../spec_helper'

describe AuthenticationsController do
  fixtures :all
  render_views

  before(:each) do
    @user = Factory(:user)
  end

  describe "signed user" do
    it "index action should render index template" do
      sign_in @user
      get :index
      response.should render_template(:index)
    end
  end
  
  describe "unsigned user" do
    it "index action should redirect to sign in page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end
end
