module MessageCenter
  
  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)

  def sendMessageToUser(to_user, from_user, subject, body, force_mail = false)
    raise MessageException::ParameterShouldBeUser.new('To User should be of type User') unless to_user.is_a? User
    raise MessageException::ParameterShouldBeUser.new('From User should be of type User') unless from_user.is_a? User
    body = view_context.sanitized_markdown(body).html_safe
    @message = Message.create(:subject => subject, :body => body, :sender_id => from_user.id, :receiver_id => to_user.id, :is_read => 0)
    
    if to_user.notify_by_email || force_mail
      UserMailer.personal_message(to_user.email, subject, body, @message, from_user).deliver
    end
  end
  
  def sendMessageToGroup(group, from_user, subject, body, force_mail = false)
    raise MessageException::ParameterShouldBeArray.new('Group should be an array') unless group.is_a? Array
    group.each do |user|
      sendMessageToUser(user, from_user, subject, body, force_mail)
    end
  end
  
  def sendMessageTemplateToGroup(group, from_user, subject, template, values, force_mail = false)
    body = render_to_string template, :layout => false, :locals => { :values => values }
    sendMessageToGroup(group, from_user, subject, body, force_mail)
  end
  
  def sendMessageTemplateToUser(to_user, from_user, subject, template, values, force_mail = false)
    sendMessageTemplateToGroup([to_user], from_user, subject, template, values, force_mail)
  end
  
end