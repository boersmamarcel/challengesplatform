# Disables registration
#
# Source; http://stackoverflow.com/questions/5370164/disabling-devise-registration-for-production-environment-only
# (second answer)
# and
# http://stackoverflow.com/questions/8466822/devise-overriding-registrations-controller-uninitialized-constant-usersregis
require "pp"
class Users::RegistrationsController < Devise::RegistrationsController
  skip_filter :require_admin, :require_supervisor, :authenticate_user!, :only => [:cancel, :edit, :update, :destroy, :new, :create]
  
  rescue_from 'RoleException::AdminLevelRequired', :with => :redirect_to_sign_in_path
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :redirect_to_sign_in_path

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    # Disable login
    @user.active = false
    # Set a random, unguessable password for this inactive user
    @user.password = Devise.friendly_token

    if @user.save
      redirect_to new_user_session_path, notice: "Your request is pending for review. We'll get back to you!"
    else
      render action: "new"
    end
  end

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
            sign_in resource_name, resource, :bypass => true
            respond_with resource, :location => after_update_path_for(resource)
        else
          render "edit"
        end
    end
  end

  def cancel
    @user = User.find(params[:id])

    throw RoleException::AdminLevelRequired unless current_user.eql? @user or current_user.is_admin?

    # You can't edit the sciencechallenges user, dummy!
    redirect_to edit_user_registration_path if @user.id.eql? 1
    if(@user.is_supervisor?)
      transfer_challenges(@user)
    end

    @user.destroy

    super cancel
  end
  
  def after_update_path_for(resource)
    profile_user_path(resource)
  end
  
end
