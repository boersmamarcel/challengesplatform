# Disables registration
#
# Source; http://stackoverflow.com/questions/5370164/disabling-devise-registration-for-production-environment-only
# (second answer)
# and
# http://stackoverflow.com/questions/8466822/devise-overriding-registrations-controller-uninitialized-constant-usersregis

class Users::RegistrationsController < Devise::RegistrationsController
  skip_filter :require_admin, :require_supervisor, :authenticate_user!, :only => [:cancel, :edit, :update, :destroy]
  
  rescue_from 'RoleException::AdminLevelRequired', :with => :redirect_to_sign_in_path
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :redirect_to_sign_in_path


  def redirect_to_sign_in_path
    redirect_to new_user_session_path
  end

  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      params[:user].delete("current_password")
    end

    @user = User.find(current_user.id)
    if params[:user][:password].blank?
      if @user.update_attributes(params[:user])
        set_flash_message :notice, :updated
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to after_update_path_for(@user)
      else
        render "edit"
      end
    elsif !params[:user][:password].blank?
          if resource.update_with_password(params[:user])
            prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
            if is_navigational_format?
              flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
                :update_needs_confirmation : :updated
              set_flash_message :notice, flash_key
            end
            sign_in resource_name, resource, :bypass => true
            respond_with resource, :location => after_update_path_for(resource)
        else
          render "edit"
        end
    else
      render "edit"
    end
  end
end
