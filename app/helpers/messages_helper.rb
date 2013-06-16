module MessagesHelper
  
  def get_date(message)
    message.created_at.strftime("%d-%m-%Y %H:%M:%S")
  end
  
  def get_name(user)
    "#{user.firstname} #{user.lastname}"
  end
  
  def get_reply_subject(message)
    if message.subject.start_with? 'Re: '
      h(message.subject)
    else
      h('Re: ' + message.subject)
    end
  end
  
end
