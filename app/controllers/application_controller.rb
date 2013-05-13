class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
   dashboard_path
  end
  
  
  def after_update_path_for(resource)
    profile_user_path(resource)
  end
end
