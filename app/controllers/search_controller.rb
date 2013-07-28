class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    @query = params[:q];

    @sunspot_search = Sunspot.search(Challenge, User, Message) do |query|
      query.fulltext @query
    end
    
    @results = @sunspot_search.results.map(&:decorate)

    render :json => @results
  end
end
