module MessagesHelper
  
  def get_date(message)
    message.created_at.strftime("%d-%m-%Y %H:%M:%S")
  end
  
  def get_name(user)
    "#{user.firstname} #{user.lastname}"
  end
  
end
