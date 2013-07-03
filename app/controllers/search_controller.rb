class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    print(params)
    print(">>>>>>>>>>>>>>>>" + params[:q])

    @results = Challenge.approved.search(params[:q]);

    if(params[:t] == "i")
      # set to 2 for testing purposes...
      @results = @results.limit(4)
    end

    @results = @results.decorate;

    render :json => @results
  end
end
