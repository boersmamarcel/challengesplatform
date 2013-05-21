class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from 'ActiveRecord::RecordNotFound', :with => :error_handler
  rescue_from 'RoleException::AdminLevelRequired', :with => :error_handler
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :error_handler

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
   dashboard_path
  end
  
  def after_update_path_for(resource)
    profile_user_path(resource)
  end

  def error_handler
    if user_signed_in?
      flash[:info] = "You do not have the permissions required to view this page."
      redirect_to dashboard_path
    else
      flash[:info] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end


  private 
      def show_404
          render :template => 'error_pages/404', :layout => false, :status => :not_found
      end

      def show_500
          render :template => 'error_pages/500', :layout => false, :status => :not_found
      end

end
