class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    # Don't respond to extremely short messages
    if(params[:q].length < 2)
      render :json => []
      return
    end

    @sunspot_search = Sunspot.search(User, Challenge, Message) do
      # Not model specific query
      fulltext params[:q].downcase

      any_of do
        # User-model specific query
        if(params[:c].nil? || params[:c].eql?('u'))
          all_of do
            with(:type, "User")
            with(:active, true)
          end
        end

        # Challenge-model specific query
        if(params[:c].nil? || params[:c].eql?('c'))
          all_of do
            with(:type, "Challenge")

            if(not current_user.is_admin?)
              any_of do
                with(:state, "approved")
                with(:supervisor_id, current_user.id)
              end
            end
          end
        end

        # Message-model specific query
        if(params[:c].nil? || params[:c].eql?('m'))
          all_of do
            with(:type, "Message")
            
            any_of do
              #with(:sender_id, current_user.id)
              with(:receiver_id, current_user.id)
            end
          end
        end
      end
    end
    
    @sunspot_search.results.map!(&:decorate)

    render :json => @sunspot_search.results
  end
end
