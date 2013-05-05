class StaticController < ApplicationController
  def index
      flash[:notice] = "Go to dashboard" if user_signed_in?
      render :index
  end
end
