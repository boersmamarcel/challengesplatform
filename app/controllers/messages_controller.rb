class MessagesController < ApplicationController
  # Allow regular users some views
  skip_filter :require_admin, :require_supervisor, :only => [:index, :show, :destroy, :compose, :deliver]

  def index
    if request.xhr?
      render "index_modal", :layout => false
    end
  end
  
  def show
    @message = current_user.received_messages.where("id = ?", params[:id]).first
    @message.is_read = true
    @message.save
  end
  
  def destroy
    @message = current_user.received_messages.where("id = ?", params[:id]).first
    @message.destroy
    
    redirect_to messages_path, :notice => "Message deleted."
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
      sendMessageToGroup(@group, params[:subject], params[:body])
      
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
    if User.exists?(params[:groupid]) && current_user.can_send_message_to_user?(User.find(params[:groupid]))
      @group = [User.find(params[:groupid])]
    end
  end
  
  private :check_challenge, :check_user
  
end
