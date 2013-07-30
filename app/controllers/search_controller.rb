class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    @query = params[:q].downcase;

    @sunspot_search = Sunspot.search(User, Challenge, Message) do
      fulltext @query

      any_of do
        all_of do
          with :type, "User"
          with :active, true
        end

        all_of do
          with :type, "Challenge"
          with :state, "approved"
        end

        all_of do
          with :type, "Message"
        end
      end
    end
    
    @sunspot_search.results.map!(&:decorate)

    render :json => @sunspot_search.results
  end
end
