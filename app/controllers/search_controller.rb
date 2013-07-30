class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def query
    @sunspot_search = Sunspot.search(User, Challenge, Message) do
      fulltext params[:q].downcase

      any_of do

        if(params[:c] != 'c' && params[:c] != 'm')
          all_of do
            with(:type, "User")
            with(:active, true)
          end
        end

        if(params[:c] != 'u' && params[:c] != 'm')
          all_of do
            with(:type, "Challenge")

            any_of do
              with(:state, "approved")
              with(:supervisor_id, current_user.id)
            end
          end
        end

        if(params[:c] != 'u' && params[:c] != 'c')
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
