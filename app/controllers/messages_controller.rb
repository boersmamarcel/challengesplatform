class MessagesController < ApplicationController
  
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
  
end
