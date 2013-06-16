class ProfileController < ApplicationController
  
  skip_filter :require_admin, :require_supervisor, :only => [:show]

  def show
    @user = User.find(params[:id]).decorate
  end
end
