class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    @query = params[:q];
    # Set the limit (lower for instant search)
    # @limit = (params[:t] == 'i') ? 6 : 50;
    # @stepsize = (params[:t] == 'i') ? 2 : 10;
    # @results = [];

    # if(not params.has_key?(:c))
    #   @results = searchMessages(@query, @stepsize);
    #   # Dynamic max-length
    #   @results = searchUsers(@query, (@limit - @stepsize - @results.count)).concat(@results);
    #   @results = searchChallenges(@query, (@limit - @results.count)).concat(@results);
    # elsif(params[:c] == 'c')
    #   @results = searchChallenges(@query, @limit);
    # elsif(params[:c] == 'u')
    #   @results = searchUsers(@query, @limit);
    # elsif(params[:c] == 'm')
    #   @results = searchMessages(@query, @limit);
    # end

    # @results = @results;

    @sunspot_search = Sunspot.search(Challenge, User, Message) do |query|
      query.fulltext @query
    end

    render :json => @sunspot_search.results
  end

  # def searchChallenges(query, limit)
  #   #search(Challenge.visible_for_user(current_user), query, limit)
  #   @search = Challenge.search do
  #     fulltext query
  #   end

  #   @search.results.each do |result|
  #     #puts result.body
  #   end
  #   #print("Results: ", @search.results)

  #   @search.results
  # end

  # def searchUsers(query, limit)
  #   search(User.active, query, limit)
  # end

  # def searchMessages(query, limit)
  #   search(Message.visible_for_user(current_user), query, limit)
  # end

  # def search(resource, query, length)
  #   resource.search(query).limit(length).decorate.to_a
  # end
end
