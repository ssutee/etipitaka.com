require File.dirname(__FILE__) + '/../spec_helper'

describe LinksController do
  fixtures :all
  render_views

  describe "non admin action" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
    end

    it "should redirect to search path" do
      get :index
      response.should redirect_to search_path
    end
  end

  describe "admin action" do
    before(:each) do
      @admin = Factory(:user, :admin => true)
      sign_in @admin
    end

    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end

    it "show action should render show template" do
      get :show, :id => Link.first
      response.should render_template(:show)
    end

    it "new action should render new template" do
      get :new
      response.should render_template(:new)
    end

    it "create action should render new template when model is invalid" do
      Link.any_instance.stubs(:valid?).returns(false)
      post :create
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      Link.any_instance.stubs(:valid?).returns(true)
      post :create
      response.should redirect_to(link_url(assigns[:link]))
    end

    it "edit action should render edit template" do
      get :edit, :id => Link.first
      response.should render_template(:edit)
    end

    it "update action should render edit template when model is invalid" do
      Link.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Link.first
      response.should render_template(:edit)
    end

    it "update action should redirect when model is valid" do
      Link.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Link.first
      response.should redirect_to(link_url(assigns[:link]))
    end

    it "destroy action should destroy model and redirect to index action" do
      link = Link.first
      delete :destroy, :id => link
      response.should redirect_to(links_url)
      Link.exists?(link.id).should be_false
    end
  end

end
