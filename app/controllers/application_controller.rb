class ApplicationController < ActionController::Base
  protect_from_forgery
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
end
