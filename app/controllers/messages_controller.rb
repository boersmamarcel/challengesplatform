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
  
  def generate
    Message.create(:subject => "The first test message", :body => "And this is the body text of that message.", :sender_id => current_user.id, :receiver_id => current_user.id, :is_read => false)
    Message.create(:subject => "A message with a very long title to see how that works, just for science", :body => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tortor est, gravida at lacinia sit amet, fringilla in lacus. Fusce rhoncus, elit a malesuada pharetra, nulla leo mollis arcu, nec euismod quam tortor in augue. Mauris nisi velit, ultricies eget gravida eu, vehicula in massa. Phasellus vestibulum porttitor lacinia. Suspendisse potenti. Nam volutpat, eros eget faucibus sollicitudin, lacus augue venenatis arcu, vel scelerisque erat nulla ut metus. Mauris dictum eros ut nunc pretium ultrices. Proin lacinia, ligula quis tempus rhoncus, dolor odio aliquam nulla, eu tempor ligula odio vel ligula. Nam fringilla, risus id vulputate venenatis, nunc elit gravida quam, quis imperdiet tortor tortor vestibulum tellus.", :sender_id => current_user.id, :receiver_id => current_user.id, :is_read => false)
  end
  
  def destroy
    @message = current_user.received_messages.where("id = ?", params[:id]).first
    @message.destroy
    
    redirect_to messages_path, :notice => "Message deleted."
  end
  
end
