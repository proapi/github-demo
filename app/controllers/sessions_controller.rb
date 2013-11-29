class SessionsController < ApplicationController

  before_filter :require_user, only: :destroy

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to restore_location, :notice => "Zostałeś zalogowawny poprawnie!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Zostałeś wylogowany poprawnie!!"
  end
end
