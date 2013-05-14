class StaticController < ApplicationController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor, :only => [:index]

  def index
      flash[:notice] = "Go to dashboard" if user_signed_in?
      render :index
  end
end
