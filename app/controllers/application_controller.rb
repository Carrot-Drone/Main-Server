class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def authenticate_admin_user!
     redirect_to new_admin_session_path if current_admin == nil
  end

  def minimum_app_version
    @json = Hash.new
    @json[:minimum_ios_version] = "3.0.0"
    @json[:minimum_android_version] = "3.0.0"

    render json: @json

  end
end
