class NewsController < ApplicationController
  def index
    @news = New.all
  end

  def show
    @new = New.find(params[:id])
  end

  def new
    @new = New.new
  end

  def create
    @new = New.new(params[:new])
    if @new.save
      redirect_to @new, :notice => "Successfully created new."
    else
      render :action => 'new'
    end
  end

  def edit
    @new = New.find(params[:id])
  end

  def update
    @new = New.find(params[:id])
    if @new.update_attributes(params[:new])
      redirect_to @new, :notice  => "Successfully updated new."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @new = New.find(params[:id])
    @new.destroy
    redirect_to news_url, :notice => "Successfully destroyed new."
  end
end
