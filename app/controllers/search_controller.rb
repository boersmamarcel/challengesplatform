class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    @results = Challenge.visible_for_user(current_user).search(params[:q]);

    if(params[:t] == "i")
      # set to 2 for testing purposes...
      @results = @results.limit(4)
    else
      @results = @results.limit(50)
    end

    @results = @results.decorate;

    render :json => @results
  end
end
