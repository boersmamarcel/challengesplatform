class MessagesController < ApplicationController
  # Allow regular users some views
  skip_filter :require_admin, :require_supervisor, :only => [:index, :show, :destroy, :compose, :deliver, :autosuggest, :tryout]

  def index
    if request.xhr?
      render "index_modal", :layout => false
    end
  end
  
  def show
    @message = current_user.received_messages.find(params[:id])
    @message.is_read = true
    @message.save
  end
  
  def destroy
    @message = current_user.received_messages.find(params[:id])
    @message.destroy
    
    redirect_to messages_path, :notice => "Message deleted."
  end
  
  def autosuggest
    search_param = params[:term].split(",").last.strip.downcase
    
    users = User.all.select{ |user| current_user.can_send_message_to_user? user }
    users.map!{ |user| { :value => user.id, :label => user.firstname + ' ' + user.lastname } }
    users.select!{ |user| user[:label].downcase.include? search_param}
    
    render :json => users
  end
  
  def compose
    # Only serve AJAX requests for now

    if request.xhr?
      render "compose_modal", :layout => false
    else
      render :nothing => true
    end
  end
  
  def deliver
    if params.has_key?(:grouptype) && params.has_key?(:groupid) && params.has_key?(:subject) && params.has_key?(:body)
      case params[:grouptype]
        when "challenge"
          check_challenge
        when "user"
          check_user
      end
    end
    
    unless defined? @group
      # If malformed request, redirect the user.
      redirect_to dashboard_path, alert: "You do not have the permissions required to view this page."
    else
      sendMessageToGroup(@group, current_user, params[:subject], params[:body])
      
      # Redirect the user to previous page and show a flash message!
      redirect_to :back, :notice => "Your message has been sent."
    end
  end
  
  def check_challenge
    if Challenge.exists?(params[:groupid]) && current_user.can_send_message_to_participants?(Challenge.find(params[:groupid]))
      @group = Challenge.find(params[:groupid]).participants
    end
  end
  
  def check_user
    user_ids = params[:groupid].split(",")
    user_ids.uniq!
    user_ids.select! { |id| User.exists?(id) && current_user.can_send_message_to_user?(User.find(id))}
    unless user_ids.empty?
      @group = user_ids.map { |id| User.find(id) }
    end
  end
  
  private :check_challenge, :check_user
  
end
