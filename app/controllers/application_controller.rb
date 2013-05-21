class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from 'ActiveRecord::RecordNotFound', :with => :show_404
  rescue_from 'RoleException::AdminLevelRequired', :with => :show_403
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :show_403

  before_filter :authenticate_user!
  before_filter :require_supervisor
  before_filter :require_admin

  def require_admin
    raise RoleException::AdminLevelRequired.new('Admin level required') unless ( !current_user.nil? && current_user.role == 2 )
  end

  def require_supervisor
    raise RoleException::SupervisorLevelRequired.new( 'Supervisor level required') unless ( (!current_user.nil?) && (current_user.role == 1 || current_user.role == 2) )
  end

  def after_sign_in_path_for(resource)
   dashboard_path
  end
  
  def after_update_path_for(resource)
    profile_user_path(resource)
  end


  def redirect_unauthorized_request
    flash[:info] = "You do not have the permissions required to view this page."
    redirect_to dashboard_path
  end

  private 
      def show_404
          render :template => 'error_pages/404', :layout => false, :status => :not_found
      end

      def show_403
          render :template => 'error_pages/403', :layout => false, :status => :not_found
      end

end
