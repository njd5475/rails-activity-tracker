class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_user_info

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_user_info
    if current_user
      @user_info = {
        username: current_user.email,
        logout_url: destroy_user_session_path
      }
    end
  end
end
