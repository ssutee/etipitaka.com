#encoding: utf-8
#
class BookmarksController < ApplicationController
  def index
    @title = "Bookmark"
  end

  def create
    if signed_in?
      current_user.bookmarks.create!(params[:bookmark])
    else
      flash.now[:notice] = "กรุณาเข้าสู่ระบบก่อนที่จะสร้างรายการจดจำ"
    end
    redirect_to params[:refer]
  end

  def destroy
    if signed_in?
      bookmark = Bookmark.find(params[:id])  
      if current_user.id == bookmark.user.id
        bookmark.delete
      else
        flash.now[:notice] = "คุณไม่มีสิทธิในการลบรายการจดจำนี้"
      end
    else
      flash.now[:notice] = "กรุณาเข้าสู่ระบบก่อนที่จะลบรายการจดจำ"
    end
    redirect_to bookmarks_path
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    @title = "Edit bookmark"
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(params[:bookmark])
      flash[:success] = 'รายการจดจำถูกแก้ไขแล้ว'
      redirect_to bookmarks_path
    else
      @title = "Edit bookmark"
      render 'edit'
    end
  end

  def share
    @title = "Share"
    if !signed_in?
      flash[:error] = "คุณไม่มีสิทธิในการเข้าถึงหน้านี้"
      redirect_to new_session_path
    end

    bookmark_id = params[:bookmark_id]
    provider = params[:provider]
    if bookmark_id.nil? or provider.nil?
      redirect_to bookmarks_path
    end
    
    bookmark = Bookmark.find(bookmark_id)
    if bookmark.nil?
      flash[:error] = "ไม่พบรายการจดจำหมายเลข:#{bookmark_id}"
      redirect_to bookmarks_path
    end

    auth = current_user.authentications.find_by_provider(provider)
    if auth.nil?
      flash[:error] = "คุณต้องเข้าสู่ระบบ #{provider.captialize} ก่อนที่จะแบ่งปันรายการจดจำ"
      redirect_to authentications_path
    end

    link = read_url(:language => bookmark.page.language,
                    :volume => bookmark.page.volume,
                    :number => bookmark.page.number)
    note = bookmark.note
    info = bookmark_info bookmark.page.id,
                         bookmark.item_number
    case provider
    when 'facebook'
      me = FbGraph::User.me(auth.token)
      me.link!(:link => link, :message => "\"#{note}\"\n- #{info}")
    when 'twitter'
      Twitter.configure do |config|
        config.consumer_key = 'tZ75FWbEdbPeO5y3D75whQ'
        config.consumer_secret = 'NznoUTLWTsbGW0G4sfu4B3UqRWNz97E70pPjCBe4U'
        config.oauth_token = auth.token
        config.oauth_token_secret = auth.secret_token
      end
      client = Twitter::Client.new
      Bitly.use_api_version_3
      bitly = Bitly.new('ssutee','R_eb3fdd519f23fb84c024a6914f8a16bf')
      client.update("\"#{note[(0..80)]}\" [#{info}] #{bitly.shorten(link).short_url}")
    end
    flash[:notice] = "การแบ่งปันรายการจดจำผ่าน #{provider.capitalize} สำเร็จแล้ว"
    redirect_to bookmarks_path
  end
end
