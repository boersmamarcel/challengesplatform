module MessageCenter
  
  def sendMessageToUser(user, subject, body)
    raise "user must be an instance of User" unless user.is_a? User
    Message.create(:subject => subject, :body => body, :sender_id => current_user.id, :receiver_id => user.id, :is_read => 0)
  end
  
  def sendMessageToGroup(group, subject, body)
    raise "group must be an array" unless group.is_a? Array
    group.each do |user|
      sendMessageToUser(user, subject, body)
    end
  end
  
end