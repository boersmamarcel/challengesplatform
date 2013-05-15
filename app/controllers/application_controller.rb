class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :require_supervisor
  before_filter :require_admin

  def require_admin
    redirect_unauthorized_request unless ( !current_user.nil? && current_user.role == 2 )
  end

  def require_supervisor
    # Also allow admins, otherwise it fails
    redirect_unauthorized_request unless ( (!current_user.nil?) && (current_user.role == 1 || current_user.role == 2) )
  end

  def redirect_unauthorized_request
    flash[:info] = "You do not have the permissions required to view this page."
    redirect_to dashboard_path
  end
  
  def after_sign_in_path_for(resource)
   dashboard_path
  end
  
  def after_update_path_for(resource)
    profile_user_path(resource)
  end
end
