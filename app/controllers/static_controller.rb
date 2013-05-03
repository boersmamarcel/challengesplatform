class StaticController < ApplicationController
  def index
      flash[:notice] = "Go to dashboard"
      render :index
   
  end
end
