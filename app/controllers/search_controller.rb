class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    @results = Challenge.approved.search(params[:q]).decorate

    respond_to do |format|
      format.json { render :json => @results }
    end
  end
end
