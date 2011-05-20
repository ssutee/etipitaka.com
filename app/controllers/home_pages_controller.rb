# encoding: utf-8
class HomePagesController < ApplicationController
  layout "main"

  def home
    @title = "Home"
  end

end
