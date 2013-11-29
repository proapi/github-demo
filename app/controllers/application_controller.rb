class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      store_location
      redirect_to root_url, :notice => "Musisz się zalogować, aby obejrzeć zawartość strony!"
      false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def restore_location
    if session[:return_to].nil?
      root_url
    else
      url = session[:return_to]
      session[:return_to] = nil
      url
    end
  end
end
