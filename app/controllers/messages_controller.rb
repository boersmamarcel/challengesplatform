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
    if request.xhr?
      render "compose_modal", :layout => false
    end
  end
  
  def deliver
    if params.has_key?(:grouptype) && params.has_key?(:groupid) && params.has_key?(:subject) && params.has_key?(:body)
      render :inline => "Hello"
    else
      render :nothing => true
    end
  end
  
end
