#encoding: utf-8

class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  include PagesHelper
  include BookmarksHelper

  def set_locale
    I18n.locale = :th
  end

  def after_sign_in_path_for(resource_or_scope)
    search_path
  end

  def after_sign_out_path_for(resource_or_scope)
    search_path
  end

  def after_sign_up_path_for(resource_or_scope)
    search_path
  end

  def authenticate
    if !signed_in?
      flash[:error] = 'คุณจำเป็นต้องเข้าสู่ระบบหรือลงทะเบียนก่อน'
      redirect_to new_user_session_path
    end
  end

  def require_admin
    if current_user.nil? or !current_user.admin?
      flash[:error] = 'คุณไม่มีสิทธิในการเข้าถึงหน้านี้'
      redirect_to search_path
    end
  end
end
