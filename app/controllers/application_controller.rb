class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: self.session[:session_token])
    @current_user
  end

  def login_user!(user)
    self.session[:session_token] = user.reset_session_token!
    current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_if_logged_out
    redirect_to new_session_url unless logged_in?
  end
end
