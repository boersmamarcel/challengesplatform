class StaticController < ApplicationController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor, :only => [:index]

  def index
      render :index
  end
end
