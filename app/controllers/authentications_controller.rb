class AuthenticationsController < ApplicationController
  before_filter :authenticate
  def index
    @title = "Sharing Setting"
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    case auth['provider']
    when 'facebook'
      current_user.authentications.
      find_or_create_by_provider_and_uid_and_token(auth['provider'], 
                                                   auth['uid'],
                                                   auth['credentials']['token'])
    when 'twitter'
      current_user.authentications.
      find_or_create_by_provider_and_uid_and_token_and_secret_token(auth['provider'], 
                                                   auth['uid'],
                                                   auth['credentials']['token'],
                                                   auth['credentials']['secret'])
    end
    flash[:notice] = "Authentication successful."
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
