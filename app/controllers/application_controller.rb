class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :require_supervisor
  before_filter :require_admin

  def require_admin
    unless ( !current_user.nil? && current_user == 2 )
      print("TOKEN Redirecting! #{!current_user.nil? && current_user == 2}")
      flash[:info] = "You do not have the permissions required to view this page"
      redirect_to dashboard_path
    end
  end

  def require_supervisor
    print("TOKEN Your role is #{current_user.try(:role)}")

    # Also allow admins, otherwise it fails
    unless ( (!current_user.nil?) && (current_user.role == 1 || current_user.role == 2) )
      print("TOKEN failed on supervisor")
      flash[:info] = "You do not have the permissions required to view this page"
      redirect_to dashboard_path
    end
  end
  
  def after_sign_in_path_for(resource)
   dashboard_path
  end
  
end
