class ApplicationController < ActionController::Base
  include MessageCenter
  
  protect_from_forgery

  rescue_from 'ActiveRecord::RecordNotFound', :with => :redirect_unauthorized_request
  rescue_from 'ActiveResource::ResourceNotFound', :with => :redirect_unauthorized_request
  rescue_from 'RoleException::AdminLevelRequired', :with => :redirect_unauthorized_request
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :redirect_unauthorized_request

  before_filter :authenticate_user!
  before_filter :require_supervisor
  before_filter :require_admin

  def require_admin
    raise RoleException::AdminLevelRequired.new('Admin level required') unless ( !current_user.nil? && current_user.role == 2 )
  end

  def require_supervisor
    raise RoleException::SupervisorLevelRequired.new('Supervisor level required') unless ( (!current_user.nil?) && (current_user.role == 1 || current_user.role == 2) )
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "You have succesfully logged in"
    dashboard_path
  end

  def redirect_unauthorized_request
    flash[:info] = "You do not have the permissions required to view this page."
    redirect_to dashboard_path
  end
end
