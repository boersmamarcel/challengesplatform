class StaticController < ApplicationController
  def index
    if current_user.nil?
      render :index
    else
      redirect_to dashboard_path
    end
  end
end
