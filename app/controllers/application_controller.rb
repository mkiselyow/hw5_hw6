class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def handle_unverified_request
    sign_out
    super
  end
  # before_filter :check_auth
  # before_filter :authorize, only: :edit
  
  # def current_premission
  #   @current_permission ||= Permission.new(current_user)
  # end

  # def authorize
  #   if !current_permission.allow?(parms[:controller], params[:action])
  #     redirect_to root_url, alert: "Not authorized"
  #   end
  # end
  private 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to signin_url, alert: "Not authorized" if current_user.nil?
    end
  helper_method :current_user
end
