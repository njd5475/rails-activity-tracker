class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ValidationErrorSerializer
  
  before_action :authenticate_user!
  before_action :set_user_info

  def set_user_info
    if current_user
      @user_info = {
        username: current_user.email,
        logout_url: destroy_user_session_path
      }
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
