# Disables registration
#
# Source; http://stackoverflow.com/questions/5370164/disabling-devise-registration-for-production-environment-only
# (second answer)
# and
# http://stackoverflow.com/questions/8466822/devise-overriding-registrations-controller-uninitialized-constant-usersregis

class Users::RegistrationsController < Devise::RegistrationsController
  skip_filter :require_admin, :require_supervisor, :authenticate_user!, :only => [:cancel, :edit, :update, :destroy]

  def new
    flash[:info] = 'We\'re sorry: only admins are allowed to create new users.'
    redirect_to new_user_session_path
  end

  def create
    flash[:info] = 'We\'re sorry: only admins are allowed to create new users.'
    redirect_to new_user_session_path
  end
end
