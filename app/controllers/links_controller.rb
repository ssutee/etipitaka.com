class LinksController < ApplicationController
  before_filter :require_admin
  layout "simple"

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to @link, :notice => "Successfully created link."
    else
      render :action => 'new'
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

    if !params[:link].nil? and params[:link][:private] == "1"
      @link.private = true
    else
      @link.private = false
    end
    @link.save

    if @link.update_attributes(params[:link])
      redirect_to @link, :notice  => "Successfully updated link."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_url, :notice => "Successfully destroyed link."
  end
end
