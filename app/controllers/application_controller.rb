class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    user ||= User.find_by(session_token: self.session[:session_token])
    user
  end

  def login_user!(user)
    current_session_token = user.reset_session_token!
    self.session[:session_token] = current_session_token
  end
end
